Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317610AbSGFEmE>; Sat, 6 Jul 2002 00:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317611AbSGFEmE>; Sat, 6 Jul 2002 00:42:04 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:1776 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S317610AbSGFEmD>; Sat, 6 Jul 2002 00:42:03 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivangurdiev@attbi.com>
Reply-To: ivangurdiev@attbi.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.25
Date: Fri, 5 Jul 2002 00:47:30 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207050047.30425.ivangurdiev@attbi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.25: 2 problems found

1) Options under Input Device Support and under Character Devices: Mice
are duplicates from a user's point of view. Fortunately they have different 
names (CONFIG_PSMOUSE vs CONFIG_MOUSE_PS2).
Unfortunately they both seem to be used...did a recursive grep.


2)  This is a compilation error, which has been in 2.5 since 3 kernels ago or 
so. Reported twice on LKML by me, as well as another person. No reply. 

mpparse.c: In function `mp_parse_prt':
mpparse.c:1080: warning: implicit declaration of function `mp_find_ioapic'
mpparse.c:1083: `mp_ioapic_routing' undeclared (first use in this function)
mpparse.c:1083: (Each undeclared identifier is reported only once
mpparse.c:1083: for each function it appears in.)
mpparse.c:1107: warning: implicit declaration of function 
`io_apic_set_pci_routing'
make[1]: *** [mpparse.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.24/arch/i386/kernel'
make: *** [arch/i386/kernel] Error 2

occurs with: 
LOCAL_APIC on, IOAPIC off, ACPI on, uniprocessor machine.


