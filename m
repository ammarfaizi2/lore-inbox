Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286323AbRLJRQ1>; Mon, 10 Dec 2001 12:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286321AbRLJRQR>; Mon, 10 Dec 2001 12:16:17 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.133]:56248 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S286323AbRLJRQC>; Mon, 10 Dec 2001 12:16:02 -0500
Date: Mon, 10 Dec 2001 12:16:02 -0500 (EST)
From: Keith Warno <krjw@optonline.net>
Subject: 2.4.16: scsi "PCI error Interrupt"?!
X-X-Sender: kw@behemoth.hobitch.com
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.40.0112101205560.6819-100000@behemoth.hobitch.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.

Since using 2.4.16 I have been seeing the following message in syslog
from time to time:

scsi0: PCI error Interrupt at seqaddr = 0x7
scsi0: Data Parity Error Detected during address or write data phase

>From time to time that 0x7 is an 0x9 and I don't know the meaning of
either of them. :)

These messages appear on my home machine and my work machine, both of
which are 2.4.16 running on a KT7A motherboard.  Work machine has an
Adaptec 29160 controller and home machine has a 2930 controller.

kw@behemoth[pts/1]:~$ # HOME MACHINE
kw@behemoth[pts/1]:~$ cat /proc/sys/kernel/tainted
1
kw@behemoth[pts/1]:~$ # because of damn NVidia driver 1.0-2313
kw@behemoth[pts/1]:~$ cat /proc/interrupts
           CPU0
  0:   21027685          XT-PIC  timer
  1:     105508          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:     895289          XT-PIC  eth0, EMU10K1
 11:     889052          XT-PIC  aic7xxx
 12:     215482          XT-PIC  usb-uhci, usb-uhci
 14:    7086454          XT-PIC  ide0
NMI:          0
ERR:          0
kw@behemoth[pts/1]:~$

kw@vader[5]:~$ # WORK MACHINE
kw@vader[5]:~$ cat /proc/sys/kernel/tainted
1
kw@vader[5]:~$ # again because of NVidia driver
kw@vader[5]:~$ cat /proc/interrupts
           CPU0
  0:   41698625          XT-PIC  timer
  1:     212688          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:     488706          XT-PIC  usb-uhci, usb-uhci
 10:    2302511          XT-PIC  eth0, EMU10K1
 11:   10676271          XT-PIC  aic7xxx, nvidia
 14:    1314711          XT-PIC  ide0
NMI:          0
ERR:          0
kw@vader[5]:~$

Any ideas?  I really don't like the SCSI controller sharing an interrupt
with anyone but I can't seem to force it to be in its own land.

Regards,
kw
| Keith Warno                keith.warno@valaran.com
| Sys Admin, Valaran Corp    direct: +1 609-945-7243
| http://www.valaran.com/    mobile: +1 609-209-5800
+---------------------------------------------------

