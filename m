Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130897AbRA3Xgf>; Tue, 30 Jan 2001 18:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130864AbRA3XgY>; Tue, 30 Jan 2001 18:36:24 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:13051 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S130897AbRA3XgL>; Tue, 30 Jan 2001 18:36:11 -0500
Date: Wed, 31 Jan 2001 00:36:07 +0100 (MET)
From: "Andreas Ackermann (Acki)" <asackerm@stud.informatik.uni-erlangen.de>
To: <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.0: [kswapd+116/272]
Message-ID: <Pine.GSO.4.30.0101310030560.22218-100000@faui02d.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

using the new Kernel it now occured for the 4th time that I get an Oops
some minutes after bootup, with X-Windows running. However, if I get
past this 'criticak period' the system seems to run ok (it never crashed
a second time although running all day), even when heavily loaded
(avifile, mtvp, transfers using samba etc.).

Here's the log:
...
Jan 29 08:08:25 ane kernel: <Sound Blaster 16> at 0x300 irq 10 dma 0,0
Jan 29 08:08:25 ane kernel: sb: 1 Soundblaster PnP card(s) found.
Jan 29 08:08:25 ane kernel: lirc_serial: compile the serial port driver
as module and
Jan 29 08:08:25 ane kernel: lirc_serial: make sure this module is loaded
first
Jan 29 08:08:26 ane kernel: lirc_serial: auto-detected active low
receiver
Jan 29 08:08:27 ane lpd[212]: restarted
Jan 29 08:17:39 ane kernel:  printing eip:
Jan 29 08:17:39 ane kernel: c013d838
Jan 29 08:17:39 ane kernel: Oops: 0002
Jan 29 08:17:39 ane kernel: CPU:    0
Jan 29 08:17:39 ane kernel: EIP:    0010:[prune_dcache+24/328]
Jan 29 08:17:39 ane kernel: EFLAGS: 00010216
Jan 29 08:17:39 ane kernel: eax: c021903c   ebx: c8b929c0   ecx:
c8b12000   edx: ffffff20
Jan 29 08:17:39 ane kernel: esi: c8b12920   edi: c8aff800   ebp:
00000d8d   esp: cbfe7fa8
Jan 29 08:17:39 ane kernel: ds: 0018   es: 0018   ss: 0018
Jan 29 08:17:39 ane kernel: Process kswapd (pid: 3, stackpage=cbfe7000)
Jan 29 08:17:39 ane kernel: Stack: 00010f00 00000004 00000002 00000000
c013dbd1 00000f8f c01278eb 00000006
Jan 29 08:17:39 ane kernel:        00000004 00010f00 c01dae77 cbfe6239
0008e000 c012798c 00000004 00000000
Jan 29 08:17:39 ane kernel:        c133ffb8 00000000 c0107418 00000000
00000078 c0229fd8
Jan 29 08:17:39 ane kernel: Call Trace: [shrink_dcache_memory+33/48]
[do_try_to_free_pages+83/128] [kswapd+116/272] [kernel_thread+40/56]
Jan 29 08:17:39 ane kernel:
Jan 29 08:17:39 ane kernel: Code: 89 02 89 1b 89 5b 04 8d 73 e0 8b 43 e4
a8 08 74 27 24 f7 89
Jan 29 08:20:58 ane syslogd 1.3-3#33.1: restart.
Jan 29 08:20:58 ane kernel: klogd 1.3-3#33.1, log source = /proc/kmsg
started.
Jan 29 08:20:58 ane kernel: Inspecting /boot/System.map-2.4.0
Jan 29 08:20:59 ane kernel: Loaded 13095 symbols from
/boot/System.map-2.4.0.
Jan 29 08:20:59 ane kernel: Symbols match kernel version 2.4.0.
Jan 29 08:20:59 ane kernel: Loaded 219 symbols from 13 modules.


If this tells somebody what it's all about I can provide further
information about system etc. I also can provide three similar excerpts
form my logfile ;-)

Yours

-Andreas
-------------------------------------------------------------------
        http://www.acki-netz.de  email: acki@acki-netz.de
   //   (+49)[0]9131/409500 or (+49)[0]9286/6399
 \X/    acki or acki2 on #rommelwood

   No trees were killed in the sending of this message. However
     a large number of electrons were terribly inconvenienced.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
