Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTDRXqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTDRXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:46:40 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:52352 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263309AbTDRXqj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:46:39 -0400
Date: Sat, 19 Apr 2003 01:58:36 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.67-mm4 & IRQ balancing
Message-Id: <20030419015836.6acbaeb6.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Importance: high
X-Priority: 1 (Highest)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

It may be not related to -mm4 only but as i hadn't checked before ( with 2.5.x kernels),
I just wonder about /proc/interrupts output:

$ cat /proc/interrupts 
           CPU0       CPU1       
  0:   47851610          0    IO-APIC-edge  timer
  1:      51789          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:        171          0    IO-APIC-edge  serial
  8:     772066          0    IO-APIC-edge  rtc
 12:          3          0    IO-APIC-edge  i8042, i8042, i8042, i8042
 15:         58          1    IO-APIC-edge  ide1
 16:      47047          0   IO-APIC-level  ohci1394
 18:     391753          0   IO-APIC-level  EMU10K1
 19:     911863          0   IO-APIC-level  uhci-hcd
 20:     261806          0   IO-APIC-level  eth0
 22:     273648          0   IO-APIC-level  aic7xxx
 23:          0          0   IO-APIC-level  uhci-hcd
NMI:   47853468   47852927 
LOC:   47860500   47860630 
ERR:          0
MIS:          0

Shouldn't the interrupts be balanced on both CPUs ? 

DELL MT 530 Ws , SMP Xeon 1.5Ghz, 512 Mo RAM on Debian Unstable.

Thanks,

Philippe
