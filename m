Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVHORCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVHORCG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVHORCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:02:06 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:18700 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S964833AbVHORCF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:02:05 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 2.6.12.3 boot problem
Date: Mon, 15 Aug 2005 13:00:47 -0400
Message-ID: <94C8C9E8B25F564F95185BDA64AB05F601F9A9B1@USTR-EXCH5.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.12.3 boot problem
Thread-Index: AcWhuuHKOWQbmbCRRvqPsN0ooo7kpA==
From: "Srinivasan, Usha" <Usha.Srinivasan@unisys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Aug 2005 17:00:49.0878 (UTC) FILETIME=[E343AF60:01C5A1BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been successfully running 2.6.11 under Red Hat RHEL4 environment
with no problems at all.  I needed to switch to 2.6.12 and chose
2.6.12.3.  However, I am having problems booting 2.6.12.3.  My SCSI HBAs
& disks are not being found at boot time and I see these errors during
boot:

Red Hat nash version 4.1.18 starting
Mkrootdev: label / not found
Umount /sys failed: 16
Mount: error 19 mounting ext3
Mount: error 2 mounting none
Switchroot: mount failed: 22
Umount /initrd/dev failed: 2


After trying many many things I have figured out what works and what
doesn't.  
 
Works:
If I build scsi_mod, sd_mod, scsi_transport_spi and aic7xxxx drivers as
built into the kernel, 2.6.12.3 boots fine.

Doesn't work:
If I build scsi_mod, sd_mod, scsi_transport_spi and aic7xxxx drivers as
Modules, 2.6.12.3 fails to boot.

I was able to run with these drivers as Modules in 2.6.11 without ANY
problems.  Has something changed in 2.6.12.3 with regards to finding
SCSI boot disks?

Please CC my work email when responding with your
suggestions/advice/comments. Thanks in advance!

Usha 
_______________________________________

Usha Srinivasan
Software Engineer
Unisys Corporation
Malvern, Pennsylvania
610-648-4392

