Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267619AbTASPg1>; Sun, 19 Jan 2003 10:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267631AbTASPg1>; Sun, 19 Jan 2003 10:36:27 -0500
Received: from vador.skynet.be ([195.238.3.236]:4741 "EHLO vador.skynet.be")
	by vger.kernel.org with ESMTP id <S267619AbTASPg0> convert rfc822-to-8bit;
	Sun, 19 Jan 2003 10:36:26 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Hans Lambrechts <hans.lambrechts@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21pre3 smp_affinity, very strange
Date: Sun, 19 Jan 2003 16:45:03 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301191645.03034.hans.lambrechts@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this recently:

pc:~ # cat /proc/interrupts
           CPU0       CPU1
  0:      39836          0    IO-APIC-edge  timer
  1:        574          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 12:      20362          0    IO-APIC-edge  PS/2 Mouse
 14:          7          0    IO-APIC-edge  ide0
 16:       8906          0   IO-APIC-level  aic7xxx
 18:        789          0   IO-APIC-level  eth0
NMI:          0          0
LOC:      39741      39740
ERR:          0
MIS:          0

pc:~ # cat /proc/irq/0/smp_affinity
ffffffff

pc:~ # echo ffffffff > /proc/irq/0/smp_affinity

pc:~ # cat /proc/interrupts
           CPU0       CPU1
  0:      50921        947    IO-APIC-edge  timer
  1:        974          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          2          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 12:      25530          0    IO-APIC-edge  PS/2 Mouse
 14:          7          0    IO-APIC-edge  ide0
 16:       8935          0   IO-APIC-level  aic7xxx
 18:        801          0   IO-APIC-level  eth0
NMI:          0          0
LOC:      51773      51772
ERR:          0
MIS:          0

Did the APIC or mpparse changes cause this?

Please cc me, I'm not on the list.
