Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUHaVJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUHaVJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHaVHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 17:07:05 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:25869 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S269176AbUHaVDr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 17:03:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: IDE class driver with SATA controllers
Date: Tue, 31 Aug 2004 14:03:41 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F969B@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: IDE class driver with SATA controllers
Thread-Index: AcSPlnIr2WgDnbT2QD2WTEOvsQckHAAAD7BgAABXO5AAAWO/wA==
From: "Andrew Chew" <achew@nvidia.com>
To: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <jgarzik@pobox.com>, <B.Zolnierkiewicz@elka.pw.edu.pl>
X-OriginalArrivalTime: 31 Aug 2004 21:03:42.0056 (UTC) FILETIME=[FECAD680:01C48F9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my perusal of the kernel code, I noticed that the IDE subsystem
handles IDE controllers at legacy IO ports if no other driver claims
them (albeit without DMA support).  I was wondering if it could be
extended to support SATA controllers 
that aren't mapped to legacy I/O ports.

I'm aware of the idex=base,ctl,irq kernel option, but I can't seem to
get this to work with my SATA controller (using ide6=base,ctl,irq).

The reason I'm asking is because it would seem like a good thing to have
SATA controllers that are broadly compatible with IDE to be usable
without having to modify the core kernel drivers.  This would at least
allow a user to perform a Linux install on a SATA drive even if that
kernel doesn't have explicit support for the SATA controller.  A
kernel/driver update can then take place after the install.

Also, are there plans for libata to take over the IDE class driver
functionality in the future?
