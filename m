Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWAZRPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWAZRPD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWAZRPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:15:02 -0500
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:61084 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932271AbWAZRPA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:15:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Problems with MSI-X on ia64 
Date: Thu, 26 Jan 2006 11:14:22 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problems with MSI-X on ia64 
Thread-Index: AcYim/OQRI88rlKjRNKZ/xkcrKUHbw==
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 26 Jan 2006 17:14:25.0883 (UTC) FILETIME=[F5632AB0:01C6229B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Has anyone tested MSI-X on ia64 based platforms? We're using a 2.6.9
variant and a cciss driver with MSI/MSI-X support. The kernel has MSI
enabled. On ia64 the MSI-X table is all zeroes. On Intel x86_64
platforms the table contains valid data and everything works as
expected.

If I understand how this works the Linux kernel is supposed to program
up the table based on the HW platform. I can't find anything in the ia64
code that does this. For x86_64 and i386 it looks like the magic address
is 

	#define APIC_DEFAULT_BASE	0xfee00000

Anybody know why this isn't defined for ia64? Any answers, input, or
flames are appreciated.

Thanks,
mikem
