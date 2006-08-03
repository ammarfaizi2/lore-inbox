Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWHCRIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWHCRIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 13:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbWHCRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 13:08:12 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:65039 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S932579AbWHCRIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 13:08:12 -0400
Message-ID: <44D22D79.2010902@xs4all.nl>
Date: Thu, 03 Aug 2006 19:08:09 +0200
From: Udo van den Heuvel <udovdh@xs4all.nl>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: And another Oops / BUG? (2.6.17.7 on VIA Epia CL6000)
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=8300CC02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aug  3 19:00:27 epia kernel: BUG: unable to handle kernel paging request
at virtual address b17f757c
Aug  3 19:00:27 epia kernel:  printing eip:
Aug  3 19:00:27 epia kernel: b17f757c
Aug  3 19:00:27 epia kernel: *pde = 00000000
Aug  3 19:00:27 epia kernel: Oops: 0000 [#1]
Aug  3 19:00:27 epia kernel: PREEMPT
Aug  3 19:00:27 epia kernel: Modules linked in: nls_utf8 cifs eeprom
sch_tbf xt_string xt_MARK xt_length xt_tcpmss xt_mac xt_mark vt1211
hwmon_vid i2c_isa ipv6 ipt_ttl ipt_owner ip_nat_irc ip_conntrack_irc
ipt_REDIRECT ipt_tos ip_nat_ftp ip_conntrack_ftp ip_nat_h323
ip_conntrack_h323 ipt_MASQUERADE ipt_LOG ipt_TCPMSS ipt_REJECT xt_limit
xt_state ipt_TARPIT iptable_filter ipt_TOS iptable_mangle xt_NOTRACK
iptable_raw binfmt_misc lp parport_pc parport nvram ehci_hcd uhci_hcd
snd_via82xx snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm i2c_viapro
snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd
Aug  3 19:00:27 epia kernel: CPU:    0
Aug  3 19:00:27 epia kernel: EIP:
0060:[phys_startup_32+-1318095492/-1073741824]    Not tainted VLI
Aug  3 19:00:27 epia kernel: EIP:    0060:[<b17f757c>]    Not tainted VLI
Aug  3 19:00:27 epia kernel: EFLAGS: 00010296   (2.6.17.7 #11)
Aug  3 19:00:27 epia kernel: EIP is at 0xb17f757c
Aug  3 19:00:27 epia kernel: eax: 00000000   ebx: 9e6d2829   ecx:
0000000d   edx: 00000001
Aug  3 19:00:27 epia kernel: esi: 7797d086   edi: ab29e28e   ebp:
06434b37   esp: c15cdf28
Aug  3 19:00:27 epia kernel: ds: 007b   es: 007b   ss: 0068
Aug  3 19:00:27 epia kernel: Process named (pid: 1530,
threadinfo=c15cc000 task=ddf7c530)
Aug  3 19:00:27 epia kernel: Stack: ca5e928b 10650bc2 6dac42f4 36c0d9d0
4812b292 36b4518a 1828be2c 43697285
Aug  3 19:00:27 epia kernel:        fc197996 cad2fd37 2973b39a 74bb65e6
c414690e 522c0279 bd796053 a755ec9f
Aug  3 19:00:27 epia kernel:        fc7af3a7 d1773d53 c006c782 4c5d404d
79f54325 3195bbe3 3f8a6c9e ead911da
Aug  3 19:00:27 epia kernel: Call Trace:
Aug  3 19:00:27 epia kernel:  <c0103675> show_stack_log_lvl+0x85/0x90
<c010380b> show_registers+0x14b/0x1c0
Aug  3 19:00:27 epia kernel:  <c01039e2> die+0x162/0x240  <c010f7d1>
do_page_fault+0x441/0x524
Aug  3 19:00:27 epia kernel:  <c010308f> error_code+0x4f/0x60
Aug  3 19:00:27 epia kernel: Code:  Bad EIP value.
Aug  3 19:00:27 epia kernel: EIP:
[phys_startup_32+-1318095492/-1073741824] 0xb17f757c SS:ESP 0068:c15cdf28
Aug  3 19:00:27 epia kernel: EIP: [<b17f757c>] 0xb17f757c SS:ESP
0068:c15cdf28

Everytime it is named that is affected.
This kernel was compiled with:

CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y

What is happening?
