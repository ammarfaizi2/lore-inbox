Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSKKTXQ>; Mon, 11 Nov 2002 14:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265906AbSKKTXQ>; Mon, 11 Nov 2002 14:23:16 -0500
Received: from polaris.galacticasoftware.com ([206.45.95.222]:32008 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id <S265901AbSKKTXO>; Mon, 11 Nov 2002 14:23:14 -0500
Date: Mon, 11 Nov 2002 13:26:48 -0600
From: adamm@galacticasoftware.com
To: linux-kernel@vger.kernel.org
Subject: Promise Ultra100 TX2 driver problems
Message-ID: <20021111192648.GA31966@galacticasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There seems to be a major problem with the promise drivers.
It is detected and seems to work, but there is a very 
large number of interrupts being generated:

adamm@polaris:/proc$ cat interrupts
           CPU0       CPU1
  0:    2727665    2683676    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  5:    1137650    1130539   IO-APIC-level  eth0
  7:          0          0    IO-APIC-edge  soundblaster
  8:       1812       1790    IO-APIC-edge  rtc
  9:     711977     709641   IO-APIC-level  sym53c8xx, eth1
 10: 2097584287 2097514818   IO-APIC-level  ide2, ide3
NMI:          0          0
LOC:    5411428    5411427
ERR:          0
MIS:       3013

adamm@polaris:/proc$ uptime
 12:57:30 up 15:01,  1 user,  load average: 0.36, 0.35, 0.40

Or a staggering ~40000 interrupts per second!

This is a dual PPro machine and it is using 30% cpu time
just to handle the interrupts.

Anyone know what is going on?

Thanks,
Adam

