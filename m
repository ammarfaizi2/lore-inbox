Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTENMmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 08:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTENMmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 08:42:54 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:43926 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262049AbTENMmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 08:42:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16066.15561.296849.757291@gargle.gargle.HOWL>
Date: Wed, 14 May 2003 14:55:37 +0200
From: mikpe@csd.uu.se
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: APIC error
In-Reply-To: <20030513.213112.184808431.rene.rebe@gmx.net>
References: <20030513.213112.184808431.rene.rebe@gmx.net>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Rebe writes:
 > Hi,
 > 
 > on a dual Pentium-mmx 233Mhz box (I got for free ...) I get many APIC
 > errors, like:
 > 
 > APIC error on CPU1: 08(00)
 > APIC error on CPU0: 02(00)
 > ... ...
 > 
 > I also sometimes got 04(00).
 > 
 > Those errors only seem to happen during high disk-io (SCSI or IDE).
 > What specific meaning do those errors have? Are they dangerous?

They are defined in Intel's IA32 manual set, volume 3,
"System Programming Guide", downloadable from developer.intel.com.

These errors mean that APIC bus messages are lost or have checksum errors.
You don't say which kernel you're using or which chipset, but chances are
your mobo's APIC bus is noisy.

 > Each CPU survives hours in memtest86 ... And with maxcpus=1 it also
 > does not seem to happen ... The BIOS is latest.

You can try booting with "noapic", that should let you keep using SMP
while avoiding your possibly buggy APIC bus.
