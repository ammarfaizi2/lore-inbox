Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284931AbRLXOUu>; Mon, 24 Dec 2001 09:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284935AbRLXOUk>; Mon, 24 Dec 2001 09:20:40 -0500
Received: from www.automatix.de ([212.4.161.35]:19468 "EHLO mail.automatix.de")
	by vger.kernel.org with ESMTP id <S284931AbRLXOUa>;
	Mon, 24 Dec 2001 09:20:30 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Juergen Sauer <jojo@automatix.de>
Organization: AutomatiX GmbH
To: Jens Gecius <jens@gecius.de>
Subject: Re: VIA Chipsets + USB + SMP == UGLY TRASH
Date: Mon, 24 Dec 2001 14:50:57 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16IRTQ-0003oN-00@s.automatix.de> <87zo48zy6l.fsf@maniac.gecius.de>
In-Reply-To: <87zo48zy6l.fsf@maniac.gecius.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E16IVVI-0005f4-00@s.automatix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Dezember 2001 11:53 schrieb Jens Gecius:
> Juergen Sauer <jojo@automatix.de> writes:
> > Hi!
> > Merry X-Mas everywhere !

> Well, it's not junk, I'd say. It works fine here on my gigabyte
> dualboard.
Exact Chipset ?
This makes many troubles:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Flags: bus master, medium devsel, latency 8
Build in in Epox epd3va.

> I used to have problems with APIC and my network card, but that's
> over. APIC works just fine with my box (USB mouse, USB scanner).

> As I was told by Alan, it's not that "cutdown" as you would expect.
Would be fine. ;->>

The IRQ routing was struggling over a lousy pci-host-bridge and an idiotic
(and ugly badly documented) irq routing on the epox board.

This one runns only with "noapic pirq=5,10,11,15" and fires up to much 
irqs onto the same one, leaving other possible resoures unused. Just have 
a look on irq 10, there are three sources of irq working. This fails 
sometimes. No wonder why. ;-<<
Also was it impossible to get suitable usb-bus-bandwith-performance for 
the scanner (HP 6350) to get it scanning withouts stopping and 
re-starting (buffer transmission to sane/xsane).

jojo@pc2:jojo $ uname -a
Linux pc2 2.4.16-xfs #7 SMP Sam Dez 1 17:46:18 CET 2001 i686 unknown

jojo@pc2:jojo $ cat /proc/interrupts
           CPU0       CPU1
  0:     606544          0          XT-PIC  timer
  1:      12278          0          XT-PIC  keyboard
  2:          0          0          XT-PIC  cascade
  5:        216          0          XT-PIC  usb-uhci
  8:          3          0          XT-PIC  rtc
 10:     316151          0          XT-PIC  ide2, Ensoniq AudioPCI, nvidia
 11:     102769          0          XT-PIC  sym53c8xx
 12:      72420          0          XT-PIC  PS/2 Mouse
 14:    1070229          0          XT-PIC  eth0, saa7146(1)
 15:          2          0          XT-PIC  ide1
NMI:          0          0
LOC:     606446     606488
ERR:          0
MIS:          0
jojo@pc2:jojo $


mfG
	J. Sauer
-- 
Jürgen Sauer - AutomatiX GmbH, +49-4209-4699, jojo@automatix.de **
** Das Linux Systemhaus - Service - Support - Server - Lösungen **
http://www.automatix.de to Mail me: remove: -not-for-spawm-     **
