Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbTA1Gjx>; Tue, 28 Jan 2003 01:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbTA1Gjx>; Tue, 28 Jan 2003 01:39:53 -0500
Received: from mail.permas.de ([195.143.204.226]:59558 "EHLO netserv.local")
	by vger.kernel.org with ESMTP id <S264863AbTA1Gjw>;
	Tue, 28 Jan 2003 01:39:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hartmut Manz <manz@home-hardy>
To: linux-kernel@vger.kernel.org
Subject: RE:[2.4.21-pre3] APIC routing broken on ASUS P2B-DS
Date: Tue, 28 Jan 2003 07:45:07 +0100
X-Mailer: KMail [version 1.3.2]
Cc: manz@intes.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18dPUa-0004hy-00@home-hardy.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2 Machines with 2.4.21-pre3aa1.
Here is my output, and you can see the interrupts are routed to both CPU's.

1 Machine is a dual Xeon (ds-1 with HT disabled, the other a dual Athlon) 

ds-1:~# cat /proc/interrupts
           CPU0       CPU1
  0:    2241873    2203779    IO-APIC-edge  timer
  1:          1          2    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:     581751     589381    IO-APIC-edge  serial
  8:          3          0    IO-APIC-edge  rtc
  9:          1          0    IO-APIC-edge  acpi
 12:         18          1    IO-APIC-edge  PS/2 Mouse
 14:          1          3    IO-APIC-edge  ide0
 16:          1         15   IO-APIC-level  aic7xxx
 17:          1         83   IO-APIC-level  aic7xxx
 18:    9535504    9781689   IO-APIC-level  eth0
 19:     230428     224831   IO-APIC-level  eth1
 24:     620506     590321   IO-APIC-level  gdth
NMI:          0          0
LOC:    4445528    4445613
ERR:          0
MIS:          0

ds-2:~# cat /proc/interrupts
           CPU0       CPU1
  0:   24844892   26513954    IO-APIC-edge  timer
  1:        914        457    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          3          0    IO-APIC-edge  rtc
  9:          0          0    IO-APIC-edge  acpi
 10:    6343634    5843815   IO-APIC-level  eth0, eth2
 11:   15050607   14898517   IO-APIC-level  ide2, ide3
 12:          2          9    IO-APIC-edge  PS/2 Mouse
 14:    2522659    2472909    IO-APIC-edge  ide0
NMI:          0          0
LOC:   51360402   51360401
ERR:          0
MIS:          5
