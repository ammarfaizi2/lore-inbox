Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRDAEP1>; Sat, 31 Mar 2001 23:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDAEPS>; Sat, 31 Mar 2001 23:15:18 -0500
Received: from hyperion.expio.net.nz ([202.27.199.10]:20232 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S131958AbRDAEPL>;
	Sat, 31 Mar 2001 23:15:11 -0500
Message-ID: <004801c0ba62$6cd67810$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: <linux-smp@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Asus CUV4X-D, 2.4.3 crashes at boot
Date: Sun, 1 Apr 2001 16:15:38 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've compiled kernel 2.4.3 on the following RH7 system, and I'm now getting
random crashes at boot, during IO-APIC initialisation. Random meaning that
sometimes it boots fine, other times it doesn't, and it hangs in different
places (but always around IO-APIC stuff). It almost always hangs after a
cold boot - if I do a Ctrl+Alt+Del then it will usually boot up OK.

System: Asus CUV4X-D motherboard, Dual P3 800EB.

The last thing I see on the screen when it hangs is, for example:



CPU1: Intel Pentium III (Coppermine) stepping 06
CPU has booted.
Before bogomips.
Total of 2 processors activated (3207.98 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
...TIMER: vector=49 pin1=2 pin2=0



Sometimes it gets a little further, but it's always somewhere near the
IO-APIC
stuff.

When it does boot, I get:



CPU1: Intel Pentium III (Coppermine) stepping 06
CPU has booted.
Before bogomips.
Total of 2 processors activated (3207.98 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-5, 2-10, 2-11, 2-13, 2-19, 2-20, 2-21, 2-22, 2-23
not connected.
..TIMER: vector=49 pin1=2 pin2=0
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00



Full dmesg output:
http://www.expio.co.nz/~sgarner/orion/smp/dmesg.txt
My kernel .config:
http://www.expio.co.nz/~sgarner/orion/smp/config.txt
Output from lspci -xx:
http://www.expio.co.nz/~sgarner/orion/smp/lspcixx.txt


Any ideas?


Thanks in advance,

Simon Garner

