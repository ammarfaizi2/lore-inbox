Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbVC0TWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVC0TWl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVC0TWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:22:41 -0500
Received: from web52907.mail.yahoo.com ([206.190.39.184]:15462 "HELO
	web52907.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261465AbVC0TWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:22:38 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=L665otUgJ76kU39rED8nL7wAFx6dQTRF3IDD2Dn18jGs5hy2WybS8rZ+59CwNbDntB32heYFdglQ8CldYSLlbuGMA7IypRQRM4YRqHvw0t04Id0omSBvjxKVLh2t33NuZ8FoQGIZqHT1lWD+ImAt04tLYBxyYCDbv1DCU6Z+2g8=  ;
Message-ID: <20050327192237.14378.qmail@web52907.mail.yahoo.com>
Date: Sun, 27 Mar 2005 20:22:37 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[gcc-3.4.3, Linux-2.6.11-SMP, Dual P4 Xeon with HT enabled]

Hi,

My Linux 2.6.11 box oopsed when I tried to logout. I have switched to using the anticipatory
scheduler instead.

Cheers,
Chris

NMI Watchdog detected LOCKUP on CPU1, eip c0275cc7, registers:
Modules linked in: snd_pcm_oss snd_mixer_oss snd_usb_audio snd_usb_lib snd_intel8x0 snd_seq_oss
snd_seq_midi snd_emu10k1_synth snd_emu10k1 snd_ac97_codec snd_pcm snd_page_alloc snd_emux_synth
snd_seq_virmidi snd_rawmidi snd_seq_midi_event snd_seq_midi_emul snd_hwdep snd_util_mem snd_seq
snd_seq_device snd_rtctimer snd_timer snd nls_iso8859_1 nls_cp437 vfat fat usb_storage radeon drm
i2c_algo_bit emu10k1_gp gameport deflate zlib_deflate zlib_inflate twofish serpent aes_i586
blowfish des sha256 crypto_null af_key binfmt_misc eeprom i2c_sensor button processor psmouse
pcspkr p4_clockmod speedstep_lib usbserial lp nfsd exportfs md5 ipv6 sd_mod scsi_mod autofs nfs
lockd sunrpc af_packet ohci_hcd parport_pc parport e1000 video1394 raw1394 i2c_i801 i2c_core
ohci1394 ieee1394 ehci_hcd soundcore pwc videodev uhci_hcd usbcore intel_agp agpgart ide_cd cdrom
ext3 jbd
CPU:    1
EIP:    0060:[<c0275cc7>]    Not tainted VLI
EFLAGS: 00200086   (2.6.11) 
EIP is at _spin_lock+0x7/0xf
eax: f7b8b01c   ebx: f7c82b88   ecx: f7c82b94   edx: f6c33714
esi: eb68ad88   edi: f6c33708   ebp: f6c33714   esp: f5b32f70
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 5757, threadinfo=f5b32000 task=f7518020)
Stack: c01f7f79 00200282 f76bda24 f6c323e4 f7518020 00000000 00000000 c01f1d0c 
       f5b32000 c011d7b3 00000001 00000000 b65ffa40 00000000 f5b32fac 00000000 
       00000000 00000000 f5b32000 c011d8d6 c0102e7f 00000000 b65ffbf0 b6640bf0 
Call Trace:
 [<c01f7f79>] cfq_exit_io_context+0x54/0xb3
 [<c01f1d0c>] exit_io_context+0x45/0x51
 [<c011d7b3>] do_exit+0x205/0x308
 [<c011d8d6>] next_thread+0x0/0xc
 [<c0102e7f>] syscall_call+0x7/0xb
Code: 05 e8 3a e6 ff ff c3 ba 00 f0 ff ff 21 e2 81 42 14 00 01 00 00 f0 81 28 00 00 00 01 74 05 e8
1d e6 ff ff c3 f0 fe 08 79 09 f3 90 <80> 38 00 7e f9 eb f2 c3 f0 81 28 00 00 00 01 74 05 e8 ff e5
ff 
console shuts up ...


Send instant messages to your online friends http://uk.messenger.yahoo.com 
