Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272355AbTHKGiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 02:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTHKGiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 02:38:03 -0400
Received: from [66.212.224.118] ([66.212.224.118]:16655 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272355AbTHKGh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 02:37:59 -0400
Date: Mon, 11 Aug 2003 02:12:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, cmrivera@ufl.edu,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts
 seems correct
In-Reply-To: <Pine.LNX.4.53.0308110148080.19193@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0308110208480.19193@montezuma.mastecende.com>
References: <1060572792.1113.10.camel@boobies.awol.org> 
 <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>  <1060574873.684.41.camel@localhost>
  <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>  <1060576517.684.47.camel@localhost>
  <34268.4.4.25.4.1060576870.squirrel@www.osdl.org> <1060577118.684.52.camel@localhost>
 <Pine.LNX.4.53.0308110121090.19193@montezuma.mastecende.com>
 <Pine.LNX.4.53.0308110148080.19193@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that it's booted;

This box has 20 irq lines and NR_IRQS = 224
Linux har-01.mastecende.com 2.6.0-test3 #12 SMP Mon Aug 11 01:56:51 EDT 2003 i686 i686 i386 GNU/Linux
root@har-01 ~ {0, 0} cat /proc/interrupts
           CPU0
  0:     386488    IO-APIC-edge  timer
  1:         98    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         57    IO-APIC-edge  i8042
 14:         10    IO-APIC-edge  ide0
 17:       2343   IO-APIC-level  BusLogic BT-958
 18:        190   IO-APIC-level  PCnet/PCI II 79C970A
 19:          0   IO-APIC-level  uhci-hcd
NMI:          0
LOC:     383054
ERR:          0
MIS:          0
root@har-01 ~ {0, 0} cat /proc/stat
cpu  13420 48 19886 4865 384
cpu0 13420 48 19887 4865 384
intr 391995 389245 98 0 0 0 0 3 0 1 0 0 0 57 0 10 0 0 2345 237 0
ctxt 20591
btime 1058859909
processes 1097
procs_running 1
procs_blocked 0

And this one has 16 irq lines and NR_IRQS = 224
Linux mondecino.mastecende.com 2.6.0-test3 #11 SMP Mon Aug 11 01:50:37 EDT 
2003 i686 i686 i386 GNU/Linux
root@mondecino ~ {0, 0} cat /proc/interrupts
           CPU0
  0:    1071356          XT-PIC  timer
  1:         12          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:        830          XT-PIC  serial
  5:       1281          XT-PIC  uhci-hcd, uhci-hcd, eth0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 12:         60          XT-PIC  i8042
 14:       1490          XT-PIC  ide0
 15:         42          XT-PIC  ide1
NMI:          0
LOC:    1070561
ERR:          0
MIS:          0
root@mondecino ~ {0, 0} cat /proc/stat
cpu  27374 0 1642 77426 1230
cpu0 27374 0 1642 77426 1230
intr 1080473 1076701 12 0 0 830 1334 0 1 1 0 0 0 60 0 1492 42
ctxt 16348
btime 1060581831
processes 1218
procs_running 2
procs_blocked 0
