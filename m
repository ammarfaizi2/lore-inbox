Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTDRPUk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTDRPUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:20:40 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:25728 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S263131AbTDRPUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:20:39 -0400
Date: Fri, 18 Apr 2003 18:32:35 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
In-Reply-To: <20030418022606.56357df4.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L0.0304181824320.1931-100000@webdev.ines.ro>
References: <20030418014536.79d16076.akpm@digeo.com>
 <Pine.LNX.4.50L0.0304181216180.1931-200000@webdev.ines.ro>
 <20030418022606.56357df4.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see this at boot time:

Trying to free free IRQ12
Trying to free free IRQ12
Trying to free free IRQ12
Trying to free free IRQ12

and /proc/interrupts says:

           CPU0
  0:     323354          XT-PIC  timer
  1:       1282          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  acpi
  8:          2          XT-PIC  rtc
 11:       1562          XT-PIC  uhci-hcd, eth0
 12:          0          XT-PIC  i8042, i8042, i8042, i8042, VIA686A
 14:       1752          XT-PIC  ide0
 15:         10          XT-PIC  ide1
NMI:          0
LOC:     323237
ERR:        745

on 2.5.67-mm1:

           CPU0
  0:      52985          XT-PIC  timer
  1:        256          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  acpi
  8:          2          XT-PIC  rtc
 11:         75          XT-PIC  uhci-hcd, eth0
 12:          0          XT-PIC  VIA686A
 14:       1892          XT-PIC  ide0
 15:         10          XT-PIC  ide1
NMI:          0
LOC:      52883
ERR:        130

