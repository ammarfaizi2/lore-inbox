Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVAOWLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVAOWLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 17:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVAOWLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 17:11:23 -0500
Received: from web52908.mail.yahoo.com ([206.190.39.185]:63672 "HELO
	web52908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262330AbVAOWKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 17:10:50 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=qsMSxUC999CwhiTh2eT5iRaxzOJJ3OzWQgTCaBAPzknpnRjV02409HXPDksHaVxq2JasYJUVPgwfg+sQcj3pBHSD3Eup2pJH8v4IntClNKWgzBLTgx9ThYobDBfN5sIQzZ8wBHk2/XnVK6ugzKAmd+kpZPXgr8yZhpBYpoiqE+A=  ;
Message-ID: <20050115221041.22337.qmail@web52908.mail.yahoo.com>
Date: Sat, 15 Jan 2005 22:10:41 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [OOPS] NMI lockup detected with CFQ, v2.6.10
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My dual Xeon P4 (with HT, 1 GB RAM) has just oopsed on
shutdown, due to a lockup in the CFQ scheduler (I
think). The compiler was gcc-3.4.3.

NMI Watchdog detected LOCKUP on CPU2, eip c026d86d,
registers:
Modules linked in: snd_pcm_oss snd_mixer_oss
snd_usb_audio snd_usb_lib snd_intel8x0 snd_seq_oss
snd_seq_midi snd_emu10k1_synth snd_emu10k1
snd_ac97_codec snd_pcm snd_page_alloc snd_emux_synth
snd_seq_virmidi snd_rawmidi snd_seq_midi_event
snd_seq_midi_emul snd_hwdep snd_util_mem snd_seq
snd_seq_device snd_rtctimer snd_timer snd
nls_iso8859_1 nls_cp437 vfat fat usb_storage sg sbp2
radeon i2c_algo_bit emu10k1_gp gameport deflate
zlib_deflate zlib_inflate twofish serpent aes_i586
blowfish des sha256 crypto_null af_key binfmt_misc
eeprom i2c_sensor button processor psmouse pcspkr
p4_clockmod speedstep_lib usbserial lp nfsd exportfs
md5 ipv6 sd_mod scsi_mod autofs nfs lockd sunrpc
af_packet ohci_hcd parport_pc parport e1000 video1394
raw1394 i2c_i801 i2c_core ohci1394 ieee1394 ehci_hcd
soundcore pwc videodev uhci_hcd usbcore intel_agp
agpgart ide_cd cdrom ext3 jbd
CPU:    2
EIP:    0060:[<c026d86d>]    Not tainted VLI
EFLAGS: 00200086   (2.6.10) 
EIP is at _spin_lock+0x7/0xf
eax: f76af01c   ebx: f6f88ba0   ecx: f6f88bac   edx:
f6f8881c
esi: f42a7dc0   edi: f6f88810   ebp: f6f8881c   esp:
f64dff6c
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 6111, threadinfo=f64df000
task=f7b28520)
Stack: c01f07ac 00200286 f7495af4 f6deb780 00000000
f7b28520 f64df000 c01ece22 
       f64df000 c011d6c9 7fffffff 00000001 00000000
b6640a40 00000000 00000000 
       00000000 00000000 00000000 f64df000 c011d76a
c0102dc3 00000000 b6640bf0 
Call Trace:
 [<c01f07ac>] cfq_exit_io_context+0x54/0xb3
 [<c01ece22>] exit_io_context+0x45/0x51
 [<c011d6c9>] do_exit+0x381/0x402
 [<c011d76a>] next_thread+0x0/0x4b
 [<c0102dc3>] syscall_call+0x7/0xb
Code: 9f c0 c3 89 c2 f0 81 28 00 00 00 01 0f 94 c0 84
c0 b9 01 00 00 00 75 09 f0 81 02 00 00 00 01 30 c9 89
c8 c3 f0 fe 08 79 09 f3 90 <80> 38 00 7e f9 eb f2 c3
f0 81 28 00 00 00 01 74 05 e8 35 ea ff 
console shuts up ...



	
	
		
___________________________________________________________ 
ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
