Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVAJQSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVAJQSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAJQSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:18:49 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:20675 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S262307AbVAJQSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:18:23 -0500
Date: Mon, 10 Jan 2005 18:18:21 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bttv/v4l2/Linux 2.6.10-ac8: xawtv hanging in videobuf_waiton
Message-ID: <20050110161821.GA5561@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050110000043.GA9549@m.safari.iki.fi> <871xct1pq2.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xct1pq2.fsf@bytesex.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 12:35:33PM +0100, Gerd Knorr wrote:
> Sami Farin <7atbggg02@sneakemail.com> writes:
> 
> > when I start xawtv and alevt in the same window and press 'v' in xawtv,
> > bttv goes berserk, producing around 25 lines per second of debug stuffs.
> > (xawtv was also in fullscreen mode when I did this).
> > alevt quits just fine.
> > 
> > Jan 10 00:43:26 safari kernel: bttv0: OCERR @ 0d1f9014,bits: HSYNC OFLOW OCERR*
> > Jan 10 00:43:26 safari last message repeated 11 times
> > Jan 10 00:43:26 safari kernel: bttv0: timeout: drop=0 irq=7236/7236, risc=0d1f901c, bits: HSYNC OFLOW
> > Jan 10 00:43:26 safari kernel: bttv0: reset, reinitialize
> > Jan 10 00:43:26 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
> > Jan 10 00:43:55 safari kernel: bttv0: OCERR @ 0d1f901c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
> 
> Any change with latest updates from http://dl.bytesex.org/patches/ ?
> 
> I can reproduce with the latest bits.  There was a state handling bug

(s/can/can't/)

> when using both video + vbi recently through, not sure whenever the
> fix made it into 2.6.10 or not.

I applied that All-2.6.10.diff.gz and now pressing 'v'
in xawtv caused nice freeze in a couple of seconds (sysrq+b did not work,
had to cycle power).

I didn't try alevt yet.

Jan 10 17:41:24 safari kernel: Linux video capture interface: v1.00
Jan 10 17:41:25 safari kernel: bttv: driver version 0.9.15 loaded
Jan 10 17:41:25 safari kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Jan 10 17:41:25 safari kernel: bttv: Host bridge needs ETBF enabled.
Jan 10 17:41:25 safari kernel: bttv: Bt8xx card found (0).
Jan 10 17:41:25 safari kernel: PCI: Found IRQ 9 for device 0000:00:0b.0
Jan 10 17:41:25 safari kernel: PCI: Sharing IRQ 9 with 0000:00:0b.1
Jan 10 17:41:25 safari kernel: bttv0: Bt878 (rev 2) at 0000:00:0b.0, irq: 9, latency: 64, mmio: 0xe9001000
Jan 10 17:41:25 safari kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
Jan 10 17:41:25 safari kernel: bttv0: using: Hauppauge (bt878) [card=10,autodetected]
Jan 10 17:41:25 safari kernel: bttv0: enabling ETBF (430FX/VP3 compatibilty)
Jan 10 17:41:25 safari kernel: bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
Jan 10 17:41:25 safari kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
Jan 10 17:41:26 safari kernel: tveeprom: Hauppauge: model = 61314, rev = B2M , serial# = 3187659
Jan 10 17:41:26 safari kernel: tveeprom: tuner = Philips FI1216 MK2 (idx = 8, type = 5)
Jan 10 17:41:26 safari kernel: tveeprom: tuner fmt = PAL(B/G) (eeprom = 0x04, v4l2 = 0x00000007)
Jan 10 17:41:26 safari kernel: tveeprom: audio_processor = MSP3415 (type = 6)
Jan 10 17:41:26 safari kernel: bttv0: using tuner=5
Jan 10 17:41:26 safari kernel: bttv0: i2c: checking for MSP34xx @ 0x80... found
Jan 10 17:41:26 safari kernel: msp34xx: init: chip=MSP3410D-B4 +nicam +simple mode=simple
Jan 10 17:41:26 safari kernel: msp3410: daemon started
Jan 10 17:41:26 safari kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Jan 10 17:41:26 safari kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Jan 10 17:41:27 safari kernel: tvaudio: TV audio decoder + audio/video mux driver
Jan 10 17:41:27 safari kernel: tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54 (PV951),ta8874z
Jan 10 17:41:27 safari kernel: bttv0: i2c: checking for TDA9887 @ 0x86... not found
Jan 10 17:41:27 safari kernel: tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
Jan 10 17:41:27 safari kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by bt878 #0 [sw]
Jan 10 17:41:28 safari kernel: bttv0: registered device video0
Jan 10 17:41:28 safari kernel: bttv0: registered device vbi0
Jan 10 17:41:29 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW OCERR*
Jan 10 17:41:51 safari last message repeated 6 times
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari last message repeated 2 times
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:51 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:52 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:53 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:54 safari kernel: bttv0: OCERR @ 0b03401c,bits: HSYNC OFLOW RISCI* OCERR*
Jan 10 17:41:54 safari kernel: bttv0: OCERR @ 0b034000,bits: HSYNC OFLOW OCERR*
Jan 10 17:41:54 safari kernel: bttv0: OCERR @ 0b034014,bits: HSYNC OFLOW OCERR*
Jan 10 17:41:54 safari last message repeated 9 times
Jan 10 17:41:54 safari kernel: bttv0: OCERR @ 0b034000,bits: HSYNC OFLOW OCERR*
Jan 10 17:41:54 safari kernel: bttv0: timeout: drop=0 irq=1110/1110, risc=06fc1ba4, bits: HSYNC OFLOW
Jan 10 17:41:54 safari kernel: bttv0: reset, reinitialize
Jan 10 17:41:54 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
Jan 10 17:41:55 safari kernel: Unable to handle kernel paging request at virtual address 0bf20ffc
Jan 10 17:41:55 safari kernel:  printing eip:
Jan 10 17:41:55 safari kernel: c016d063
Jan 10 17:41:55 safari kernel: *pde = 00000000
Jan 10 17:41:55 safari kernel: Oops: 0000 [#1]
Jan 10 17:41:55 safari kernel: Modules linked in: tuner tvaudio msp3400 bttv
	i2c_algo_bit videodev ohci_hcd binfmt_misc sch_hfsc sch_htb sch_sfq cls_fw
	cls_u32 cls_route sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred
	cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark xfs loop snd_seq_oss
	snd_seq_midi_event snd_seq lp parport_pc parport w83781d i2c_sensor video_buf
	v4l2_common i2c_piix4 btcx_risc tveeprom i2c_core ipt_ECN ipt_multiport
	ipt_connlimit ipt_TARPIT ipt_length ipt_owner usb_storage dm_mod uhci_hcd
	snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss
	snd_mixer_oss snd_pcm ipt_REJECT ip6t_LOG ipt_LOG ipt_limit snd_timer
	ipt_state snd ip6table_mangle ip6table_filter ip6_tables soundcore
	snd_page_alloc iptable_filter iptable_mangle iptable_nat gameport ip_conntrack
	ip_tables irlan irda crc_ccitt 8139too mii floppy
Jan 10 17:41:55 safari kernel: CPU:    0
Jan 10 17:41:55 safari kernel: EIP:    0060:[<c016d063>]    Not tainted VLI
Jan 10 17:41:55 safari kernel: EFLAGS: 00010216   (2.6.10-ac8) 
Jan 10 17:41:55 safari kernel: EIP is at poll_freewait+0x23/0x50
Jan 10 17:41:55 safari kernel: eax: ceb69f44   ebx: 0bf20fe4   ecx: 00000000   edx: 00000001
Jan 10 17:41:55 safari kernel: esi: cae02008   edi: cae02000   ebp: ceb69ee8   esp: ceb69edc
Jan 10 17:41:55 safari kernel: ds: 007b   es: 007b   ss: 0068
Jan 10 17:41:55 safari kernel: Process root-tail (pid: 5434, threadinfo=ceb68000 task=ce4449e0)
Jan 10 17:41:55 safari kernel: Stack: 00000000 00000000 00000009 ceb69f60 c016d4c9 ceb69f44 00000000 00000000 
Jan 10 17:41:55 safari kernel:        00000000 00000100 00000000 00000000 00000000 00000009 00000304 00000100 
Jan 10 17:41:55 safari kernel:        ceb68000 cd1cf4f8 cd1cf4f4 cd1cf4f0 cd1cf504 cd1cf500 cd1cf4fc 00000000 
Jan 10 17:41:55 safari kernel: Call Trace:
Jan 10 17:41:55 safari kernel:  [<c0103edf>] show_stack+0x7f/0xa0
Jan 10 17:41:55 safari kernel:  [<c0104076>] show_registers+0x156/0x1d0
Jan 10 17:41:55 safari kernel:  [<c0104278>] die+0xc8/0x150
Jan 10 17:41:55 safari kernel:  [<c0115b12>] do_page_fault+0x4a2/0x6d9
Jan 10 17:41:55 safari kernel:  [<c0103b7f>] error_code+0x2b/0x30
Jan 10 17:41:55 safari kernel:  [<c016d4c9>] do_select+0x289/0x2a0
Jan 10 17:41:55 safari kernel:  [<c016d76d>] sys_select+0x24d/0x560
Jan 10 17:41:55 safari kernel:  [<c0103123>] syscall_call+0x7/0xb
Jan 10 17:41:55 safari kernel: Code: 00 00 5d c3 8d 74 26 00 55 89 e5 8b 45 08 57 56 53 8b 78 04 85 ff 74 38 8b 5f 04 8d 77 08 8d 76 00 8d bc 27 00 00 00 00 83 eb 1c <8b> 43 18 8d 53 04 e8 b2 44 fc ff 8b 03 e8 eb e0 fe ff 39 de 72 
Jan 10 17:42:00 safari kernel:  <6>bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:00 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW OCERR*
Jan 10 17:42:01 safari last message repeated 5 times
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* FBUS OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW OCERR*
Jan 10 17:42:01 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW OCERR*
Jan 10 17:42:01 safari last message repeated 4 times
Jan 10 17:42:02 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW FBUS OCERR*
Jan 10 17:42:02 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW OCERR*
Jan 10 17:42:02 safari last message repeated 2 times
Jan 10 17:42:02 safari kernel: bttv0: timeout: drop=0 irq=1230/1230, risc=0bef7b64, bits: VSYNC HSYNC OFLOW
Jan 10 17:42:02 safari kernel: bttv0: reset, reinitialize
Jan 10 17:42:02 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
Jan 10 17:42:04 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW FBUS OCERR*
Jan 10 17:42:04 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW FBUS OCERR*
Jan 10 17:42:04 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW OCERR*
Jan 10 17:42:04 safari last message repeated 9 times
Jan 10 17:42:04 safari kernel: bttv0: timeout: drop=0 irq=1249/1249, risc=0b03401c, bits: HSYNC OFLOW
Jan 10 17:42:04 safari kernel: bttv0: reset, reinitialize
Jan 10 17:42:04 safari kernel: bttv0: PLL: 28636363 => 35468950 . ok
Jan 10 17:42:05 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:05 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:05 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:05 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*

...snip...

Jan 10 17:42:18 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:18 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:18 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:19 safari kernel: bttv0: OCERR @ 0b03401c,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:42:19 safari kernel: bttv0: OCERR @ 0b034014,bits: VSYNC HSYNC OFLOW RISCI* OCERR*
Jan 10 17:47:59 safari kernel: klogd 1.4.1, log source = /proc/kmsg started.



Dump of assembler code for function poll_freewait:
0xc016d040 <poll_freewait+0>:   push   %ebp
0xc016d041 <poll_freewait+1>:   mov    %esp,%ebp
0xc016d043 <poll_freewait+3>:   mov    0x8(%ebp),%eax
0xc016d046 <poll_freewait+6>:   push   %edi
0xc016d047 <poll_freewait+7>:   push   %esi
0xc016d048 <poll_freewait+8>:   push   %ebx
0xc016d049 <poll_freewait+9>:   mov    0x4(%eax),%edi
0xc016d04c <poll_freewait+12>:  test   %edi,%edi
0xc016d04e <poll_freewait+14>:  je     0xc016d088 <poll_freewait+72>
0xc016d050 <poll_freewait+16>:  mov    0x4(%edi),%ebx
0xc016d053 <poll_freewait+19>:  lea    0x8(%edi),%esi
0xc016d056 <poll_freewait+22>:  lea    0x0(%esi),%esi
0xc016d059 <poll_freewait+25>:  lea    0x0(%edi),%edi
0xc016d060 <poll_freewait+32>:  sub    $0x1c,%ebx
0xc016d063 <poll_freewait+35>:  mov    0x18(%ebx),%eax
0xc016d066 <poll_freewait+38>:  lea    0x4(%ebx),%edx
0xc016d069 <poll_freewait+41>:  call   0xc0131520 <remove_wait_queue>
0xc016d06e <poll_freewait+46>:  mov    (%ebx),%eax
0xc016d070 <poll_freewait+48>:  call   0xc015b160 <fput>
0xc016d075 <poll_freewait+53>:  cmp    %ebx,%esi
0xc016d077 <poll_freewait+55>:  jb     0xc016d060 <poll_freewait+32>
0xc016d079 <poll_freewait+57>:  mov    %edi,%eax
0xc016d07b <poll_freewait+59>:  xor    %edx,%edx
0xc016d07d <poll_freewait+61>:  mov    (%edi),%edi
0xc016d07f <poll_freewait+63>:  call   0xc0140180 <free_pages>
0xc016d084 <poll_freewait+68>:  test   %edi,%edi
0xc016d086 <poll_freewait+70>:  jne    0xc016d050 <poll_freewait+16>
0xc016d088 <poll_freewait+72>:  pop    %ebx
0xc016d089 <poll_freewait+73>:  pop    %esi
0xc016d08a <poll_freewait+74>:  pop    %edi
0xc016d08b <poll_freewait+75>:  pop    %ebp
0xc016d08c <poll_freewait+76>:  ret    
End of assembler dump.



-- 
