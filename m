Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270385AbTHLPJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270426AbTHLPJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:09:59 -0400
Received: from hal-4.inet.it ([213.92.5.23]:9139 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S270385AbTHLPJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:09:53 -0400
From: Paolo Ornati <javaman@katamail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21] USB very strange problems!
Date: Tue, 12 Aug 2003 17:10:33 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308121701.17563.javaman@katamail.com>
Cc: marcelo@conectiva.com.br
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, (sorry if my English is a little bad :-)

I'm using Video4Linux + USB support + USB STV680 (Pencam) Camera support to get
my web-cam "Oregon Scientific DS-3868" work and I have some troubles and an "Oops"!

INFO ON MY SYSTEM:
- kernel 2.4.21

HARDWARE: (lspci)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: bus master, medium devsel, latency 8
	Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e0000000-e3dfffff
	Prefetchable memory behind bridge: e3f00000-e5ffffff
	Capabilities: [80] Power Management version 2

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: bus master, stepping, medium devsel, latency 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at b800 [size=16]
	Capabilities: [c0] Power Management version 2

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Flags: medium devsel, IRQ 9
	Capabilities: [68] Power Management version 2

00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A [FM801] (rev b2)
	Subsystem: Fortemedia, Inc: Unknown device 1319
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9400 [size=128]
	Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801 game port] (rev b2)
	Subsystem: Fortemedia, Inc: Unknown device 1319
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9000 [size=16]
	Capabilities: [dc] Power Management version 1

00:0d.0 Network controller: Cologne Chip Designs GmbH ISDN network controller [HFC-PCI] (rev 02)
	Subsystem: Cologne Chip Designs GmbH ISDN Board
	Flags: bus master, medium devsel, latency 16, IRQ 5
	I/O ports at 8800 [disabled] [size=8]
	Memory at df800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 8400 [size=8]
	I/O ports at 8000 [size=4]
	I/O ports at 7800 [size=8]
	I/O ports at 7400 [size=4]
	I/O ports at 7000 [size=64]
	Memory at df000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03) (prog-if 00 [VGA])
	Subsystem: Creative Labs 3D Blaster Banshee VE
	Flags: 66Mhz, fast devsel, IRQ 11
	Memory at e0000000 (32-bit, non-prefetchable) [size=32M]
	Memory at e4000000 (32-bit, prefetchable) [size=32M]
	I/O ports at d800 [size=256]
	Expansion ROM at e3ff0000 [disabled] [size=64K]
	Capabilities: [54] AGP version 1.0
	Capabilities: [60] Power Management version 1


KERNEL CONFIG (only the most relevant things):

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y

#
# USB support
#
CONFIG_USB=y
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set
...
CONFIG_USB_STV680=m
...


FOR MY TEST I USE "camorama" and "SANE"

1) Both with "UHCI" and "UHCI ALternate" drivers I have some troubles:

after using camorama OR SANE for few minutes the driver stop working,
in the case of "UHCI" I get messages like these:

Aug 12 15:47:18 pablohost kernel:   176: [c009a120] link (0009a150) e3 Length=3f MaxLen=3f DT0 EndPt=2 Dev=2, PID=69(IN) (buf=00242c00)
Aug 12 15:47:18 pablohost kernel:   177: [c009a150] link (0009a180) e3 Length=3f MaxLen=3f DT1 EndPt=2 Dev=2, PID=69(IN) (buf=00242c40)
...
Aug 12 15:47:18 pablohost kernel:   320: [c009bc30] link (0009bc60) e3 Length=3f MaxLen=3f DT0 EndPt=2 Dev=2, PID=69(IN) (buf=00245000)
Aug 12 15:47:18 pablohost kernel:   321:   322:   323:   324:   325:   326:   327:   328:   329:   330:   331:   332:   333:   334:   335:   336:   337:   338:   339:   340:   341:   342:   343:   344:   345:   346:   347:   348:   349:   350:   351:   352:   353:   354:   355:   356:   357:   358:   359:   360:   361:   362:   363:   364:   365:   366:   367:   368:   369:   370:   371:   372:   373:   374:   375:   376:   377:   378:   379:   380:   381:   382:   383:   384:   385:   386:   387:   388:   389:   390:   391:   392:   393:   394:   395:   396:   397:   398:   399:   400:   401:   402:   403:   404:   405:   406:   407:   408:   409:   410:   411:   412:   413:   414:   415:   416:   417:   418:   419:   420:   421:   422:   423:   424:   425:   426:   427:   428:   429:   430:   431:   432:   433:   434:   435:   436:   437:   438:   439:   440:   441:   442:   443:   444:   445:   446:   447:   448:   449:   450:   451:   452:   453:   454:   455:   456:   457:   458:   459:   460:   461:   462:
Aug 12 15:47:18 pablohost kernel: uhci.c: b400: host controller halted. very bad
Aug 12 15:48:25 pablohost kernel: usb_control/bulk_msg: timeout

"host controller halted. very bad":
		if ((status & USBSTS_HCH) && !uhci->is_suspended) {
			err("%x: host controller halted. very bad", io_addr);
			/* FIXME: Reset the controller, fix the offending TD */
		}
YES someone must FIX you!
But I don't understand why this happen...

2) The Oops seems to happen only with "UHCI" driver in this way:

Now that the host controller is halted, as I'm very wicked, I had tried to
unplug my web-cam and then to replug it, in this way the Oops turns out:
(NOTE: I had copied it by hand and here I report only the things that don't change,
so there aren't registers and stack...)

ksymoops 2.4.9 on i686 2.4.21min.  Options used
     -v /usr/src/minimal/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21min/ (default)
     -m /boot/System.map-2.4.21min (specified)

c8913113
Oops: 0002
CPU: 0
EIP: 0010 : [<c8913113>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 0, stackpage=c023f000)
Call Trace: [<c89131cc>] [<c0108845>] [<c01089c4>] [<c0105360>] [<c010af58>]
            [<c0105360>] [<c0105383>] [<c01053f2>] [<c0105000>]
Code: c7 46 20 98 ff ff ff 8b 43 10 8b 1b 8b 80 c8 00 00 00 8b 40


>>EIP; c8913113 <[uhci]uhci_remove_pending_qhs+43/90>   <=====

Trace; c89131cc <[uhci]uhci_interrupt+6c/100>
Trace; c0108845 <handle_IRQ_event+45/70>
Trace; c01089c4 <do_IRQ+64/a0>
Trace; c0105360 <default_idle+0/30>
Trace; c010af58 <call_do_IRQ+5/d>
Trace; c0105360 <default_idle+0/30>
Trace; c0105383 <default_idle+23/30>
Trace; c01053f2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c8913113 <[uhci]uhci_remove_pending_qhs+43/90>
00000000 <_EIP>:
Code;  c8913113 <[uhci]uhci_remove_pending_qhs+43/90>   <=====
   0:   c7 46 20 98 ff ff ff      movl   $0xffffff98,0x20(%esi)   <=====
Code;  c891311a <[uhci]uhci_remove_pending_qhs+4a/90>
   7:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c891311d <[uhci]uhci_remove_pending_qhs+4d/90>
   a:   8b 1b                     mov    (%ebx),%ebx
Code;  c891311f <[uhci]uhci_remove_pending_qhs+4f/90>
   c:   8b 80 c8 00 00 00         mov    0xc8(%eax),%eax
Code;  c8913125 <[uhci]uhci_remove_pending_qhs+55/90>
  12:   8b 40 00                  mov    0x0(%eax),%eax

<0>Kernel panic: Aiee, killing interrupt handler!


Had I forgotten something?

NOTE: this problem happens also on 2.4.22-rc2.

Bye,
Paolo

