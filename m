Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUBSOlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267217AbUBSOlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:41:04 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:6876 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S267291AbUBSOhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:37:24 -0500
Date: Thu, 19 Feb 2004 16:32:22 +0100 (CET)
From: Michael Sauer <sauer@okolni.de>
X-X-Sender: sauer@vivane
To: linux-kernel@vger.kernel.org
Subject: linux 2.6.2 kernel oops
Message-ID: <Pine.LNX.4.58.0402191631230.794@vivane>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Several crashes with X-Server when configuring tv-application / file
system going wild

[2.] After configuring my videocapture card (bttv module) and trying to put
the application to full screen the X-Server crashed several times. After I
was able to run xawtv without problems, i wanted to delete stuff from my
home-directory (own ext3 partition). This was not possible any more and
there was a file called 'Segmantation fault'. I could not remove it, nor
ls -l it, just ls it. Tab completion / rm -f made the bash segfault. I tried
to reboot the machine, but it hang during reboot process and i had to hard
reset it. The home partition was not damaged by that, but my root partition
(ext3 too). I had to run e2fsck manually. Trying to do an e2fsck on my home
partition the kernel told me it's not a partition and i shall use another
superblock or reboot. I did the reboot, everything runs fine again it seems.

[3.] media/video modules, ext3, kernel

[4.] Linux version 2.6.2 (root@vivane) (gcc version 3.3.2 (Debian)) #1 Wed
Feb 11 11:57:51 CET 2004

[5.] relevant part from syslog:
Feb 19 14:03:06 vivane kernel: tuner: TV freq (0.00) out of range (44-958)
Feb 19 14:03:12 vivane kernel: bttv0: skipped frame. no signal? high irq latency? [main=3772e000,o_vbi=20423000,o_field=3772e020,rc=20423024]
Feb 19 14:03:12 vivane last message repeated 2 times
Feb 19 14:03:12 vivane kernel: bttv0: skipped frame. no signal? high irq latency? [main=3772e000,o_vbi=161e7000,o_field=3772e020,rc=161e7024]
Feb 19 14:03:12 vivane kernel: bttv0: skipped frame. no signal? high irq latency? [main=3772e000,o_vbi=161e7000,o_field=3772e020,rc=161e7024]
Feb 19 14:04:10 vivane fetchmail[3918]: awakened at Thu Feb 19 14:04:10 2004
Feb 19 14:04:20 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:04:20 2004
Feb 19 14:09:20 vivane fetchmail[3918]: awakened at Thu Feb 19 14:09:20 2004
Feb 19 14:09:28 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:09:28 2004
Feb 19 14:11:37 vivane kernel: bttv0: skipped frame. no signal? high irq latency? [main=3772e000,o_vbi=3772e018,o_field=a580000,rc=a58001c]
Feb 19 14:11:37 vivane last message repeated 3 times
Feb 19 14:11:51 vivane gconfd (sauer-613): Received signal 1, shutting down cleanly
Feb 19 14:11:51 vivane gconfd (sauer-613): Exiting
Feb 19 14:12:07 vivane kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb 19 14:12:07 vivane kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb 19 14:12:07 vivane kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb 19 14:12:07 vivane kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb 19 14:12:10 vivane gconfd (sauer-7064): starting (version 2.4.0.1), pid 7064 user 'sauer'
Feb 19 14:12:10 vivane gconfd (sauer-7062): starting (version 2.4.0.1), pid 7062 user 'sauer'
Feb 19 14:12:10 vivane gconfd (sauer-7062): Failed to get lock for daemon, exiting: Failed to lock '/tmp/gconfd-sauer/lock/ior': probably another process has the lock, or your operating system has NFS file locking misconfigured (Resource temporarily unavailable)
Feb 19 14:12:10 vivane gconfd (sauer-7064): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
Feb 19 14:12:10 vivane gconfd (sauer-7064): Resolved address "xml:readwrite:/home/sauer/.gconf" to a writable config source at position 1
Feb 19 14:12:10 vivane gconfd (sauer-7064): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
Feb 19 14:12:16 vivane kernel: cdrom: This disc doesn't have any tracks I recognize!
Feb 19 14:14:28 vivane fetchmail[3918]: awakened at Thu Feb 19 14:14:28 2004
Feb 19 14:14:36 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:14:36 2004
Feb 19 14:16:51 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:51 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:51 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:51 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:51 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:52 vivane last message repeated 8 times
Feb 19 14:16:52 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:53 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:53 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:53 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:54 vivane last message repeated 8 times
Feb 19 14:16:54 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:54 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:55 vivane last message repeated 12 times
Feb 19 14:16:55 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:55 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:56 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:56 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:58 vivane last message repeated 26 times
Feb 19 14:16:58 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:58 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:16:59 vivane last message repeated 6 times
Feb 19 14:16:59 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:16:59 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:01 vivane last message repeated 27 times
Feb 19 14:17:01 vivane /USR/SBIN/CRON[7154]: (root) CMD (   run-parts --report /etc/cron.hourly)
Feb 19 14:17:01 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:02 vivane last message repeated 9 times
Feb 19 14:17:02 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:02 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:02 vivane last message repeated 14 times
Feb 19 14:17:02 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:02 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:05 vivane last message repeated 68 times
Feb 19 14:17:05 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:05 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:05 vivane last message repeated 3 times
Feb 19 14:17:05 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:05 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:06 vivane last message repeated 17 times
Feb 19 14:17:06 vivane kernel: bttv0: SCERR @ 3772e01c,bits: OFLOW SCERR*
Feb 19 14:17:06 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:07 vivane last message repeated 18 times
Feb 19 14:17:07 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:07 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:07 vivane last message repeated 19 times
Feb 19 14:17:08 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:08 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:08 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:08 vivane last message repeated 7 times
Feb 19 14:17:08 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:08 vivane kernel: bttv0: SCERR @ 3772e01c,bits: HSYNC OFLOW SCERR*
Feb 19 14:17:08 vivane last message repeated 12 times
Feb 19 14:17:08 vivane kernel: bttv0: timeout: irq=37067/37067, risc=331f601c, bits: HSYNC OFLOW
Feb 19 14:17:08 vivane kernel: bttv0: reset, reinitialize
Feb 19 14:17:09 vivane kernel: bttv0: PLL: 28636363 => 35468950 . ok
Feb 19 14:17:32 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS FTRGT FDSR SCERR*
Feb 19 14:17:32 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS FDSR SCERR*
Feb 19 14:17:32 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:32 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:33 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS FDSR SCERR*
Feb 19 14:17:33 vivane last message repeated 2 times
Feb 19 14:17:33 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS FTRGT FDSR SCERR*
Feb 19 14:17:33 vivane kernel: bttv0: SCERR @ 3772e01c,bits: VSYNC HSYNC OFLOW FBUS SCERR*
Feb 19 14:17:54 vivane last message repeated 507 times
Feb 19 14:17:54 vivane kernel: bttv0: timeout: irq=37620/37621, risc=3772e01c, bits: HSYNC OFLOW FBUS
Feb 19 14:17:54 vivane kernel: bttv0: reset, reinitialize
Feb 19 14:17:54 vivane kernel: bttv0: PLL: 28636363 => 35468950 . ok
Feb 19 14:19:36 vivane fetchmail[3918]: awakened at Thu Feb 19 14:19:36 2004
Feb 19 14:19:45 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:19:45 2004
Feb 19 14:24:45 vivane fetchmail[3918]: awakened at Thu Feb 19 14:24:45 2004
Feb 19 14:24:53 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:24:53 2004
Feb 19 14:27:21 vivane gconfd (sauer-7064): Received signal 1, shutting down cleanly
Feb 19 14:27:21 vivane gconfd (sauer-7064): Exiting
Feb 19 14:27:36 vivane kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb 19 14:27:36 vivane kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb 19 14:27:36 vivane kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
Feb 19 14:27:36 vivane kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
Feb 19 14:27:39 vivane gconfd (sauer-7251): starting (version 2.4.0.1), pid 7251 user 'sauer'
Feb 19 14:27:39 vivane gconfd (sauer-7251): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
Feb 19 14:27:39 vivane gconfd (sauer-7251): Resolved address "xml:readwrite:/home/sauer/.gconf" to a writable config source at position 1
Feb 19 14:27:39 vivane gconfd (sauer-7251): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
Feb 19 14:27:39 vivane gconfd (sauer-7253): starting (version 2.4.0.1), pid 7253 user 'sauer'
Feb 19 14:27:39 vivane gconfd (sauer-7253): Failed to get lock for daemon, exiting: Failed to lock '/tmp/gconfd-sauer/lock/ior': probably another process has the lock, or your operating system has NFS file locking misconfigured (Resource temporarily unavailable)
Feb 19 14:27:39 vivane kernel: cdrom: This disc doesn't have any tracks I recognize!
Feb 19 14:29:53 vivane fetchmail[3918]: awakened at Thu Feb 19 14:29:53 2004
Feb 19 14:29:57 vivane fetchmail[3918]: 1 message for misa0000 at sbustd.stud.uni-sb.de (2547 octets).
Feb 19 14:29:58 vivane fetchmail[3918]: reading message misa0000@sbustd.stud.uni-sb.de:1 of 1 (2043 octets)
Feb 19 14:29:58 vivane postfix/smtpd[7283]: connect from localhost[127.0.0.1]
Feb 19 14:29:58 vivane postfix/smtpd[7283]: 3106232B44: client=localhost[127.0.0.1]
Feb 19 14:29:58 vivane postfix/cleanup[7285]: 3106232B44: message-id=<bc7c01c3f773$952df975$736a75e5@reg.fi>
Feb 19 14:29:58 vivane fetchmail[3918]:  flushed
Feb 19 14:29:58 vivane postfix/qmgr[3043]: 3106232B44: from=<kforbes_gm@cordis.lu>, size=2342, nrcpt=1 (queue active)
Feb 19 14:29:59 vivane postfix/local[7288]: 3106232B44: to=<sauer@localhost>, relay=local, delay=1, status=bounced (internal software error)
Feb 19 14:29:59 vivane postfix/cleanup[7285]: B90FE32C42: message-id=<20040219132959.B90FE32C42@okolni.de>
Feb 19 14:29:59 vivane postfix/qmgr[3043]: B90FE32C42: from=<>, size=3885, nrcpt=1 (queue active)
Feb 19 14:30:00 vivane postfix/smtp[7293]: B90FE32C42: to=<kforbes_gm@cordis.lu>, relay=mrvdom.kundenserver.de[212.227.126.223], delay=1, status=bounced (host mrvdom.kundenserver.de[212.227.126.223] said: 550 relaying to <kforbes_gm@cordis.lu> prohibited by administrator (in reply to RCPT TO command))
Feb 19 14:30:02 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:30:02 2004
Feb 19 14:30:02 vivane postfix/smtpd[7283]: disconnect from localhost[127.0.0.1]
Feb 19 14:34:43 vivane kernel: bttv0: skipped frame. no signal? high irq latency? [main=3772e000,o_vbi=3772e018,o_field=1232c000,rc=1232c024]
Feb 19 14:35:02 vivane fetchmail[3918]: awakened at Thu Feb 19 14:35:02 2004
Feb 19 14:38:10 vivane fetchmail[3918]: POP3 connection to sbustd.stud.uni-sb.de failed: Connection timed out
Feb 19 14:38:10 vivane fetchmail[3918]: Query status=2 (SOCKET)
Feb 19 14:38:14 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:38:14 2004
Feb 19 14:43:14 vivane fetchmail[3918]: awakened at Thu Feb 19 14:43:14 2004
Feb 19 14:46:23 vivane fetchmail[3918]: POP3 connection to sbustd.stud.uni-sb.de failed: Connection timed out
Feb 19 14:46:23 vivane fetchmail[3918]: Query status=2 (SOCKET)
Feb 19 14:46:26 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:46:26 2004
Feb 19 14:51:26 vivane fetchmail[3918]: awakened at Thu Feb 19 14:51:26 2004
Feb 19 14:54:35 vivane fetchmail[3918]: POP3 connection to sbustd.stud.uni-sb.de failed: Connection timed out
Feb 19 14:54:35 vivane fetchmail[3918]: Query status=2 (SOCKET)
Feb 19 14:54:39 vivane fetchmail[3918]: sleeping at Thu Feb 19 14:54:39 2004
Feb 19 14:56:46 vivane kernel: Unable to handle kernel paging request at virtual address 2cde9c2c
Feb 19 14:56:46 vivane kernel:  printing eip:
Feb 19 14:56:46 vivane kernel: c016e9bc
Feb 19 14:56:46 vivane kernel: *pde = 00000000
Feb 19 14:56:46 vivane kernel: Oops: 0000 [#1]
Feb 19 14:56:46 vivane kernel: CPU:    0
Feb 19 14:56:46 vivane kernel: EIP:    0060:[<c016e9bc>]    Tainted: P
Feb 19 14:56:46 vivane kernel: EFLAGS: 00010283
Feb 19 14:56:46 vivane kernel: EIP is at iput+0x1c/0x80
Feb 19 14:56:46 vivane kernel: eax: 2cde9c08   ebx: c88ba14c   ecx: ea4f9900   edx: f7ff7cfc
Feb 19 14:56:46 vivane kernel: esi: e012a5c0   edi: f7271000   ebp: c88ba14c   esp: c833ff68
Feb 19 14:56:46 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:56:46 vivane kernel: Process rm (pid: 7440, threadinfo=c833e000 task=cf4d4c80)
Feb 19 14:56:46 vivane kernel: Stack: fffffffb e012a5c0 fffffffb c0164840 c88ba14c f7271000 ea4f9900 f7ff4f00
Feb 19 14:56:46 vivane kernel:        f7271000 0000000c 52fdace2 00000010 00000000 00033422 2a01a584 000279f7
Feb 19 14:56:46 vivane kernel:        cf4d4c80 cf4d4e44 0805326f 0805326f 08050038 c833e000 c010941b 0805326f
Feb 19 14:56:46 vivane kernel: Call Trace:
Feb 19 14:56:46 vivane kernel:  [<c0164840>] sys_unlink+0x120/0x150
Feb 19 14:56:46 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:56:46 vivane kernel:
Feb 19 14:56:46 vivane kernel: Code: 8b 40 24 74 51 85 c0 74 07 8b 48 14 85 c9 75 3e 8d 43 1c c7
Feb 19 14:56:50 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9c2c
Feb 19 14:56:50 vivane kernel:  printing eip:
Feb 19 14:56:50 vivane kernel: c016e9bc
Feb 19 14:56:50 vivane kernel: *pde = 00000000
Feb 19 14:56:50 vivane kernel: Oops: 0000 [#2]
Feb 19 14:56:50 vivane kernel: CPU:    0
Feb 19 14:56:50 vivane kernel: EIP:    0060:[<c016e9bc>]    Tainted: P
Feb 19 14:56:50 vivane kernel: EFLAGS: 00010283
Feb 19 14:56:50 vivane kernel: EIP is at iput+0x1c/0x80
Feb 19 14:56:50 vivane kernel: eax: 2cde9c08   ebx: c88ba14c   ecx: ea4f9900   edx: f7ff7cfc
Feb 19 14:56:50 vivane kernel: esi: e012a5c0   edi: f7271000   ebp: c88ba14c   esp: db5e3f68
Feb 19 14:56:50 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:56:50 vivane kernel: Process rm (pid: 7443, threadinfo=db5e2000 task=f7357940)
Feb 19 14:56:50 vivane kernel: Stack: fffffffb e012a5c0 fffffffb c0164840 c88ba14c f7271000 ea4f9900 f7ff4f00
Feb 19 14:56:50 vivane kernel:        f7271000 0000000c 52fdace2 00000010 00000000 db5e3fa0 080531c4 080531a4
Feb 19 14:56:50 vivane kernel:        00000fb0 ffffffea 080531b7 080531b7 08050038 db5e2000 c010941b 080531b7
Feb 19 14:56:50 vivane kernel: Call Trace:
Feb 19 14:56:50 vivane kernel:  [<c0164840>] sys_unlink+0x120/0x150
Feb 19 14:56:50 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:56:50 vivane kernel:
Feb 19 14:56:50 vivane kernel: Code: 8b 40 24 74 51 85 c0 74 07 8b 48 14 85 c9 75 3e 8d 43 1c c7
Feb 19 14:57:14 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:14 vivane kernel:  printing eip:
Feb 19 14:57:14 vivane kernel: c015e03d
Feb 19 14:57:14 vivane kernel: *pde = 00000000
Feb 19 14:57:14 vivane kernel: Oops: 0000 [#3]
Feb 19 14:57:14 vivane kernel: CPU:    0
Feb 19 14:57:14 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:14 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:14 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:14 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: f6fb9f38   edx: 2cde9000
Feb 19 14:57:14 vivane kernel: esi: f6fb9f7c   edi: bffff3b0   ebp: f6fb8000   esp: f6fb9f10
Feb 19 14:57:14 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:14 vivane kernel: Process ls (pid: 7452, threadinfo=f6fb8000 task=e17272e0)
Feb 19 14:57:14 vivane kernel: Stack: f7ff7cfc f7271000 f6fb9f7c 00000000 f6fb9f38 bffff3b0 c015e16c f7ff4f00
Feb 19 14:57:14 vivane kernel:        e012a5c0 f6fb9f7c e012a5c0 f7ff4f00 4034c0a2 15d48298 00000002 00000000
Feb 19 14:57:14 vivane kernel:        00000001 c0290a35 00000246 00000000 f6fb9f7c f1a6db0c f6fb9f7c 0805b088
Feb 19 14:57:14 vivane kernel: Call Trace:
Feb 19 14:57:14 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:14 vivane kernel:  [<c0290a35>] ei_interrupt+0x1b5/0x220
Feb 19 14:57:14 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:14 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:14 vivane kernel:  [<c01674ef>] sys_getdents64+0x9f/0xa9
Feb 19 14:57:14 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:14 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
Feb 19 14:57:14 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
Feb 19 14:57:14 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:14 vivane kernel:
Feb 19 14:57:14 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:15 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:15 vivane kernel:  printing eip:
Feb 19 14:57:15 vivane kernel: c015e03d
Feb 19 14:57:15 vivane kernel: *pde = 00000000
Feb 19 14:57:15 vivane kernel: Oops: 0000 [#4]
Feb 19 14:57:15 vivane kernel: CPU:    0
Feb 19 14:57:15 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:15 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:15 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:15 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: f6fb9f38   edx: 2cde9000
Feb 19 14:57:15 vivane kernel: esi: f6fb9f7c   edi: bffff3a0   ebp: f6fb8000   esp: f6fb9f10
Feb 19 14:57:15 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:15 vivane kernel: Process ls (pid: 7453, threadinfo=f6fb8000 task=e17272e0)
Feb 19 14:57:15 vivane kernel: Stack: f7ff7cfc f7271000 f6fb9f7c 00000000 f6fb9f38 bffff3a0 c015e16c f7ff4f00
Feb 19 14:57:15 vivane kernel:        e012a5c0 f6fb9f7c e012a5c0 f7ff4f00 4034c0b9 3b770610 4034c09e 00000000
Feb 19 14:57:15 vivane kernel:        00000001 07162ed8 00000246 00000000 f6fb9f7c f1a6db0c f6fb9f7c 0805b088
Feb 19 14:57:15 vivane kernel: Call Trace:
Feb 19 14:57:15 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:15 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:15 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:15 vivane kernel:  [<c01674ef>] sys_getdents64+0x9f/0xa9
Feb 19 14:57:15 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:15 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
Feb 19 14:57:15 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
Feb 19 14:57:15 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:15 vivane kernel:
Feb 19 14:57:15 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:16 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:16 vivane kernel:  printing eip:
Feb 19 14:57:16 vivane kernel: c015e03d
Feb 19 14:57:16 vivane kernel: *pde = 00000000
Feb 19 14:57:16 vivane kernel: Oops: 0000 [#5]
Feb 19 14:57:16 vivane kernel: CPU:    0
Feb 19 14:57:16 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:16 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:16 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:16 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: d5ba3f38   edx: 2cde9000
Feb 19 14:57:16 vivane kernel: esi: d5ba3f7c   edi: bffff1a0   ebp: d5ba2000   esp: d5ba3f10
Feb 19 14:57:16 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:16 vivane kernel: Process bash (pid: 7434, threadinfo=d5ba2000 task=f6f160c0)
Feb 19 14:57:16 vivane kernel: Stack: f7ff7cfc f7271000 d5ba3f7c 00000000 d5ba3f38 bffff1a0 c015e16c f7ff4f00
Feb 19 14:57:16 vivane kernel:        e012a5c0 d5ba3f7c e012a5c0 f7ff4f00 4034c0bb 02a6f828 4034c09e 00000000
Feb 19 14:57:16 vivane kernel:        00000001 f2d8f780 ea4f9900 c016b962 ea4f9900 c04a29f0 d5ba3f7c 080f0e68
Feb 19 14:57:16 vivane kernel: Call Trace:
Feb 19 14:57:16 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:16 vivane kernel:  [<c016b962>] dput+0x22/0x210
Feb 19 14:57:16 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:16 vivane kernel:  [<c0153ad9>] filp_close+0x59/0x90
Feb 19 14:57:16 vivane kernel:  [<c0153b71>] sys_close+0x61/0xa0
Feb 19 14:57:16 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:16 vivane kernel:
Feb 19 14:57:16 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:21 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:21 vivane kernel:  printing eip:
Feb 19 14:57:21 vivane kernel: c015e03d
Feb 19 14:57:21 vivane kernel: *pde = 00000000
Feb 19 14:57:21 vivane kernel: Oops: 0000 [#6]
Feb 19 14:57:21 vivane kernel: CPU:    0
Feb 19 14:57:21 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:21 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:21 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:21 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: f6fb9f38   edx: 2cde9000
Feb 19 14:57:21 vivane kernel: esi: f6fb9f7c   edi: bffff3b0   ebp: f6fb8000   esp: f6fb9f10
Feb 19 14:57:21 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:21 vivane kernel: Process ls (pid: 7457, threadinfo=f6fb8000 task=e17272e0)
Feb 19 14:57:21 vivane kernel: Stack: f7ff7cfc f7271000 f6fb9f7c 00000000 f6fb9f38 bffff3b0 c015e16c f7ff4f00
Feb 19 14:57:21 vivane kernel:        e012a5c0 f6fb9f7c e012a5c0 f7ff4f00 4034c0bc 28aa4718 4034c09e 00000000
Feb 19 14:57:21 vivane kernel:        00000001 07162ed8 00000246 00000000 f6fb9f7c f1a6db0c f6fb9f7c 0805b088
Feb 19 14:57:21 vivane kernel: Call Trace:
Feb 19 14:57:21 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:21 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:21 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:21 vivane kernel:  [<c01674ef>] sys_getdents64+0x9f/0xa9
Feb 19 14:57:21 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:21 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
Feb 19 14:57:21 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
Feb 19 14:57:21 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:21 vivane kernel:
Feb 19 14:57:21 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:22 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:22 vivane kernel:  printing eip:
Feb 19 14:57:22 vivane kernel: c015e03d
Feb 19 14:57:22 vivane kernel: *pde = 00000000
Feb 19 14:57:22 vivane kernel: Oops: 0000 [#7]
Feb 19 14:57:22 vivane kernel: CPU:    0
Feb 19 14:57:22 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:22 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:22 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:22 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: f6fb9f38   edx: 2cde9000
Feb 19 14:57:22 vivane kernel: esi: f6fb9f7c   edi: bffff3b0   ebp: f6fb8000   esp: f6fb9f10
Feb 19 14:57:22 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:22 vivane kernel: Process ls (pid: 7458, threadinfo=f6fb8000 task=e17272e0)
Feb 19 14:57:22 vivane kernel: Stack: f7ff7cfc f7271000 f6fb9f7c 00000000 f6fb9f38 bffff3b0 c015e16c f7ff4f00
Feb 19 14:57:22 vivane kernel:        e012a5c0 f6fb9f7c e012a5c0 f7ff4f00 4034c0c1 2992c8d8 4034c09e 00000000
Feb 19 14:57:22 vivane kernel:        00000001 07162ed8 00000246 00000000 f6fb9f7c f1a6db0c f6fb9f7c 0805b088
Feb 19 14:57:22 vivane kernel: Call Trace:
Feb 19 14:57:22 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:22 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:22 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:22 vivane kernel:  [<c01674ef>] sys_getdents64+0x9f/0xa9
Feb 19 14:57:22 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:22 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
Feb 19 14:57:22 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
Feb 19 14:57:22 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:22 vivane kernel:
Feb 19 14:57:22 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:24 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:24 vivane kernel:  printing eip:
Feb 19 14:57:24 vivane kernel: c015e03d
Feb 19 14:57:24 vivane kernel: *pde = 00000000
Feb 19 14:57:24 vivane kernel: Oops: 0000 [#8]
Feb 19 14:57:24 vivane kernel: CPU:    0
Feb 19 14:57:24 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:24 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:24 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:24 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: f6fb9f38   edx: 2cde9000
Feb 19 14:57:24 vivane kernel: esi: f6fb9f7c   edi: bffff3b0   ebp: f6fb8000   esp: f6fb9f10
Feb 19 14:57:24 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:24 vivane kernel: Process ls (pid: 7459, threadinfo=f6fb8000 task=e17272e0)
Feb 19 14:57:24 vivane kernel: Stack: f7ff7cfc f7271000 f6fb9f7c 00000000 f6fb9f38 bffff3b0 c015e16c f7ff4f00
Feb 19 14:57:24 vivane kernel:        e012a5c0 f6fb9f7c e012a5c0 f7ff4f00 4034c0c2 20be81f8 4034c09e 00000000
Feb 19 14:57:24 vivane kernel:        00000001 07162ed8 00000246 00000000 f6fb9f7c f1a6db0c f6fb9f7c 0805b088
Feb 19 14:57:24 vivane kernel: Call Trace:
Feb 19 14:57:24 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:24 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:24 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:24 vivane kernel:  [<c01674ef>] sys_getdents64+0x9f/0xa9
Feb 19 14:57:24 vivane kernel:  [<c0167310>] filldir64+0x0/0x140
Feb 19 14:57:24 vivane kernel:  [<c01199c0>] do_page_fault+0x0/0x53c
Feb 19 14:57:24 vivane kernel:  [<c0109e45>] error_code+0x2d/0x38
Feb 19 14:57:24 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:24 vivane kernel:
Feb 19 14:57:24 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:25 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:25 vivane kernel:  printing eip:
Feb 19 14:57:25 vivane kernel: c015e03d
Feb 19 14:57:25 vivane kernel: *pde = 00000000
Feb 19 14:57:25 vivane kernel: Oops: 0000 [#9]
Feb 19 14:57:25 vivane kernel: CPU:    0
Feb 19 14:57:25 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:25 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:25 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:25 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: f6fb9f38   edx: 2cde9000
Feb 19 14:57:25 vivane kernel: esi: f6fb9f7c   edi: bffff3b0   ebp: f6fb8000   esp: f6fb9f10
Feb 19 14:57:25 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:25 vivane kernel: Process ls (pid: 7460, threadinfo=f6fb8000 task=e17272e0)
Feb 19 14:57:25 vivane kernel: Stack: f7ff7cfc f7271000 f6fb9f7c 00000000 f6fb9f38 bffff3b0 c015e16c f7ff4f00
Feb 19 14:57:25 vivane kernel:        e012a5c0 f6fb9f7c e012a5c0 f7ff4f00 00000286 00000c50 f6fb9f88 00000000
Feb 19 14:57:25 vivane kernel:        00000001 e61d29c0 c04a29f0 f6fb9f88 f6fb9f88 0805efa8 f6fb9f7c 0805b088
Feb 19 14:57:25 vivane kernel: Call Trace:
Feb 19 14:57:25 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:25 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:25 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:25 vivane kernel:
Feb 19 14:57:25 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:29 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9038
Feb 19 14:57:29 vivane kernel:  printing eip:
Feb 19 14:57:29 vivane kernel: c015e03d
Feb 19 14:57:29 vivane kernel: *pde = 00000000
Feb 19 14:57:29 vivane kernel: Oops: 0000 [#10]
Feb 19 14:57:29 vivane kernel: CPU:    0
Feb 19 14:57:29 vivane kernel: EIP:    0060:[<c015e03d>]    Tainted: P
Feb 19 14:57:29 vivane kernel: EFLAGS: 00010282
Feb 19 14:57:29 vivane kernel: EIP is at vfs_getattr+0x1d/0xa0
Feb 19 14:57:29 vivane kernel: eax: e012a5c0   ebx: c88ba14c   ecx: d5ba3f38   edx: 2cde9000
Feb 19 14:57:29 vivane kernel: esi: d5ba3f7c   edi: bffff1a0   ebp: d5ba2000   esp: d5ba3f10
Feb 19 14:57:29 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:29 vivane kernel: Process bash (pid: 7455, threadinfo=d5ba2000 task=f6f160c0)
Feb 19 14:57:29 vivane kernel: Stack: f7ff7cfc f7271000 d5ba3f7c 00000000 d5ba3f38 bffff1a0 c015e16c f7ff4f00
Feb 19 14:57:29 vivane kernel:        e012a5c0 d5ba3f7c e012a5c0 f7ff4f00 0000000a c016b8e4 f7ff7c14 00000000
Feb 19 14:57:29 vivane kernel:        00000001 db388e00 ea4f9900 c016b962 ea4f9900 c04a29f0 d5ba3f7c 080e6988
Feb 19 14:57:29 vivane kernel: Call Trace:
Feb 19 14:57:29 vivane kernel:  [<c015e16c>] vfs_lstat+0x4c/0x60
Feb 19 14:57:29 vivane kernel:  [<c016b8e4>] d_callback+0x24/0x40
Feb 19 14:57:29 vivane kernel:  [<c016b962>] dput+0x22/0x210
Feb 19 14:57:29 vivane kernel:  [<c015e8cb>] sys_lstat64+0x1b/0x40
Feb 19 14:57:29 vivane kernel:  [<c0153ad9>] filp_close+0x59/0x90
Feb 19 14:57:29 vivane kernel:  [<c0153b71>] sys_close+0x61/0xa0
Feb 19 14:57:29 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:29 vivane kernel:
Feb 19 14:57:29 vivane kernel: Code: 8b 4a 38 85 c9 74 22 89 44 24 04 89 74 24 08 8b 44 24 1c 89
Feb 19 14:57:55 vivane kernel:  <1>Unable to handle kernel paging request at virtual address 2cde9c2c
Feb 19 14:57:55 vivane kernel:  printing eip:
Feb 19 14:57:55 vivane kernel: c016e9bc
Feb 19 14:57:55 vivane kernel: *pde = 00000000
Feb 19 14:57:55 vivane kernel: Oops: 0000 [#11]
Feb 19 14:57:55 vivane kernel: CPU:    0
Feb 19 14:57:55 vivane kernel: EIP:    0060:[<c016e9bc>]    Tainted: P
Feb 19 14:57:55 vivane kernel: EFLAGS: 00010283
Feb 19 14:57:55 vivane kernel: EIP is at iput+0x1c/0x80
Feb 19 14:57:55 vivane kernel: eax: 2cde9c08   ebx: c88ba14c   ecx: ea4f9900   edx: f7ff7cfc
Feb 19 14:57:55 vivane kernel: esi: e012a5c0   edi: f7271000   ebp: c88ba14c   esp: e5353f68
Feb 19 14:57:55 vivane kernel: ds: 007b   es: 007b   ss: 0068
Feb 19 14:57:55 vivane kernel: Process rm (pid: 7466, threadinfo=e5352000 task=f6f160c0)
Feb 19 14:57:55 vivane kernel: Stack: fffffffb e012a5c0 fffffffb c0164840 c88ba14c f7271000 ea4f9900 f7ff4f00
Feb 19 14:57:55 vivane kernel:        f7271000 0000000c 52fdace2 00000010 00000000 e5353fa0 080531c4 080531a4
Feb 19 14:57:55 vivane kernel:        00000fb0 ffffffea 080531b7 080531b7 08050038 e5352000 c010941b 080531b7
Feb 19 14:57:55 vivane kernel: Call Trace:
Feb 19 14:57:55 vivane kernel:  [<c0164840>] sys_unlink+0x120/0x150
Feb 19 14:57:55 vivane kernel:  [<c010941b>] syscall_call+0x7/0xb
Feb 19 14:57:55 vivane kernel:
Feb 19 14:57:55 vivane kernel: Code: 8b 40 24 74 51 85 c0 74 07 8b 48 14 85 c9 75 3e 8d 43 1c c7
Feb 19 14:59:39 vivane fetchmail[3918]: awakened at Thu Feb 19 14:59:39 2004
Feb 19 14:59:55 vivane gconfd (sauer-7251): Received signal 1, shutting down cleanly
Feb 19 14:59:55 vivane gconfd (sauer-7251): Exiting
Feb 19 15:00:54 vivane shutdown[7619]: shutting down for system reboot
Feb 19 15:00:55 vivane init: init_setenv: INIT_HALT, (null), 10
Feb 19 15:00:55 vivane init: Switching to runlevel: 6
Feb 19 15:01:01 vivane fetchmail[3918]: terminated with signal 15
Feb 19 15:01:03 vivane postfix/postfix-script: stopping the Postfix mail system
Feb 19 15:01:03 vivane postfix/master[3041]: terminating on signal 15
Feb 19 15:01:03 vivane xfs[437]: terminating
Feb 19 15:01:04 vivane Xprt_64: Xprint server pid=513 done, exitcode=0.
Feb 19 15:01:06 vivane rpc.statd[526]: Caught signal 15, un-registering and exiting.
Feb 19 15:01:06 vivane kernel: Kernel logging (proc) stopped.
Feb 19 15:01:06 vivane kernel: Kernel log daemon terminating.
Feb 19 15:01:06 vivane exiting on signal 15

[6.] not possible, perhaps try running xawtv with
xawtv -d /dev/video -xv

[7.]
[7.1]
root@vivane:/usr/src/linux>sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux vivane 2.6.2 #1 Wed Feb 11 11:57:51 CET 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre9
e2fsprogs              1.35-WIP
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         nvidia tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev analog gameport joydev hid usbmouse ehci_hcd ohci_hcd uhci_hcd usbcore rtc

[7.2.]
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 7
model name      : AMD Duron(tm)
stepping        : 1
cpu MHz         : 1303.733
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2564.09

[7.3.]
nvidia 2071272 12 - Live 0xf8c6c000
tuner 16908 0 - Live 0xf89ee000
tvaudio 20556 0 - Live 0xf89e7000
msp3400 22820 0 - Live 0xf89d3000
bttv 142508 0 - Live 0xf8a03000
video_buf 17092 1 bttv, Live 0xf89da000
i2c_algo_bit 8904 1 bttv, Live 0xf89c9000
v4l2_common 4928 1 bttv, Live 0xf89c6000
btcx_risc 3848 1 bttv, Live 0xf897f000
i2c_core 19204 5 tuner,tvaudio,msp3400,bttv,i2c_algo_bit, Live 0xf89cd000
videodev 7616 1 bttv, Live 0xf8977000
analog 9792 0 - Live 0xf89ba000
gameport 3584 1 analog, Live 0xf897d000
joydev 8832 0 - Live 0xf898f000
hid 23168 0 - Live 0xf89bf000
usbmouse 4288 0 - Live 0xf897a000
ehci_hcd 22596 0 - Live 0xf89af000
ohci_hcd 16256 0 - Live 0xf898a000
uhci_hcd 29712 0 - Live 0xf8981000
usbcore 98460 7 hid,usbmouse,ehci_hcd,ohci_hcd,uhci_hcd, Live 0xf8995000
rtc 10680 0 - Live 0xf88c7000

[7.4.]
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0400-040f : 0000:00:07.4
0800-08ff : 0000:00:07.4
0c00-0c7f : 0000:00:07.4
0cf8-0cff : PCI conf1
7000-7fff : PCI Bus #01
b800-b81f : 0000:00:07.2
  b800-b81f : uhci_hcd
bc00-bc1f : 0000:00:07.3
  bc00-bc1f : uhci_hcd
c000-c01f : 0000:00:0a.0
  c000-c01f : ne2k-pci
c400-c43f : 0000:00:0e.0
  c400-c43f : Ensoniq AudioPCI
c800-c83f : 0000:00:0f.0
  c800-c83f : Ensoniq AudioPCI
cc00-cc3f : 0000:00:10.0
d000-d003 : 0000:00:10.0
d400-d407 : 0000:00:10.0
d800-d803 : 0000:00:10.0
dc00-dc07 : 0000:00:10.0
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0037d2d8 : Kernel code
  0037d2d9-004634ff : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
cdc00000-ddcfffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
dddfe000-dddfefff : 0000:00:0d.0
  dddfe000-dddfefff : bttv0
dddff000-dddfffff : 0000:00:0d.1
dde00000-dfefffff : PCI Bus #01
  de000000-deffffff : 0000:01:00.0
dffe0000-dfffffff : 0000:00:10.0
e0000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

[7.5.]
root@vivane:~>lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00007000-00007fff
        Memory behind bridge: dde00000-dfefffff
        Prefetchable memory behind bridge: cdc00000-ddcfffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at ffa0 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at bc00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at c000 [size=32]

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at dddfe000 (32-bit, prefetchable) [size=4K]

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at dddff000 (32-bit, prefetchable) [size=4K]

00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Giga-byte Technology 5880 AudioPCI On Motherboard 6OXET
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at c400 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c800 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at dc00 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 2: I/O ports at d400 [size=8]
        Region 3: I/O ports at d000 [size=4]
        Region 4: I/O ports at cc00 [size=64]
        Region 5: Memory at dffe0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at dffd0000 [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS/Pro] (rev a4) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at dfef0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

[7.6.]
root@vivane:~>ls -l /proc/scsi
ls: /proc/scsi: No such file or directory

[7.7.]
root@vivane:~>xawtv --version
This is xawtv-3.90, running on Linux/i686 (2.6.2)

root@vivane:~>X -version
This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.2.1.1 (Debian 4.2.1-12.1 20031003005825 james@nocrew.org) / X Window System
(protocol Version 11, revision 0, vendor release 6600)
Release Date: 18 October 2002
        If the server is older than 6-12 months, or if your card is
        newer than the above date, look for a newer version before
        reporting problems.  (See http://www.XFree86.Org/)
Build Operating System: Linux 2.4.21-rc1-ac1-cryptoloop i686 [ELF]
Module Loader present

root@vivane:~>ls -l
[snip]
-rw-r--r--    1 root     root         6.6M Feb 11 12:02 NVIDIA-Linux-x86-1.0-5336-pkg1.run
[snap]

[X.] it was scary, first time linux crashed in 9 years Oo
If possible please send me a confirmation that this e-mail arrived.

mIc

...und dann war da noch der Statistiker, der in einem Fluﬂ ertrank, der im Durchschnitt nur 10 cm tief war.
