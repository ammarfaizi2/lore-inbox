Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756664AbWKSNhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664AbWKSNhs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 08:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756665AbWKSNhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 08:37:47 -0500
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:14859 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S1756664AbWKSNhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 08:37:45 -0500
Date: Sun, 19 Nov 2006 14:37:42 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: oops while booting using serial console [2.6.17]
Message-ID: <20061119133742.GI31268@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sun Nov 19 00:08:47 CET 2006
X-Message-Flag: MultiTail - tail on steroids
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. PROBLEM: oops while booting using serial console [2.6.17]

2. when booting 2.6.17 with 'console=ttyS0' parameter, things crash after the "shpchp: Standard Hot Plug PCI Controller Driver version: 0.4" comes up

4. 2.6.17

6.
BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000c
 printing eip:
b0200282
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: i2c_viapro shpchp pci_hotplug i2c_core floppy via_ircc via_agp agpgart rtc eth1394 via82cxxx_audio uart401 sound ac97_codec irda crc_ccitt snd_via82xx evdev gameport snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd_mpu401_uart psmouse snd_rawmidi snd_seq_device snd serio_raw 8250_pnp soundcore pcspkr parport_pc parport ext3 jbd mbcache dm_mirror dm_snapshot dm_mod ide_generic ide_cd cdrom ide_disk ohci1394 ieee1394 uhci_hcd via82cxxx generic ehci_hcd 8139too 8139cp via_rhine mii usbcore ide_core thermal processor fan
CPU:    0
EIP:    0060:[<b0200282>]    Not tainted VLI
EFLAGS: 00010206   (2.6.17-2-686 #1)
EIP is at uart_write_room+0x9/0x16
eax: cef56400   ebx: 00000006   ecx: ce0ea0b0   edx: 00000000
esi: ce0b0000   edi: ceb07000   ebp: 00000006   esp: ce053f18
ds: 007b   es: 007b   ss: 0068
Process S03udev (pid: 2007, threadinfo=ce052000 task=ce0ea0b0)
Stack: b01f456d ceb07000 b165cb80 00000282 00000000 ce0ea0b0 b0116f2d ce0b0138
       ce0b0138 00000006 ce0b0000 00000006 00000006 b01f21d3 00000006 080e9408
       b165cb80 b01f448c ce0b000c ce0b03e8 00000000 b01f2b64 b165cb80 b165cb80
Call Trace:
 <b01f456d> write_chan+0xe1/0x293  <b0116f2d> default_wake_function+0x0/0xc
 <b01f21d3> tty_write+0x147/0x1d8  <b01f448c> write_chan+0x0/0x293
 <b01f2b64> redirected_tty_write+0x1c/0x6c  <b01f2b48> redirected_tty_write+0x0/0x6c
 <b0153379> vfs_write+0xa1/0x140  <b0153963> sys_write+0x3c/0x63
 <b0102b4f> syscall_call+0x7/0xb
Code: 09 08 8b 40 10 74 09 81 60 10 ff ff ff fd eb 07 81 48 10 00 00 00 02 8b 5e 68 89 f0 ff 53 2c 5b 5e c3 8b 80 80 01 00 00 8b 50 10 <8b> 42 0c 2b 42 08 48 25 ff 0f 00 00 c3 8b 80 80 01 00 00 8b 50
EIP: [<b0200282>] uart_write_room+0x9/0x16 SS:ESP 0068:ce053f18

8.2
folkert@tompoes:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 9
model name      : VIA Nehemiah
stepping        : 1
cpu MHz         : 999.639
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge cmov mmx fxsr sse fxsr_opt up
bogomips        : 2001.30





Folkert van Heusden

-- 
www.biglumber.com <- site where one can exchange PGP key signatures 
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
