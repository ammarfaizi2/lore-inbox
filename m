Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbUCZOIJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUCZOIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:08:09 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:38404 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261959AbUCZOIG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:08:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6529.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: cciss update for 2.6
Date: Fri, 26 Mar 2004 08:08:05 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF105BC1F6F@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cciss update for 2.6
Thread-Index: AcQTAjMGOmwxyv5RSfuoEnncMQmsIQAOWzhA
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <akpm@osdl.org>, <axboe@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Mar 2004 14:08:05.0887 (UTC) FILETIME=[C268E8F0:01C4133B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've resubmitted the patch without HDIO_GETGEO_BIG. Sorry for my confusion.

mikem

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Friday, March 26, 2004 1:16 AM
To: Miller, Mike (OS Dev)
Cc: akpm@osdl.org; axboe@suse.de; linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6


On Thu, Mar 25, 2004 at 04:46:41PM -0600, mike.miller@hp.com wrote:
> Please consider this patch for inclusion in the 2.6 kernel.
> 
> If no device is attached we now return -ENXIO instead of some bogus numbers.
> Prevents applications from trying to access non-existent disks.
> Also adds HDIO_GETGEO_BIG IOCTL that fdisk uses.

HDIO_GETGEO_BIG was only used by some horribly patched vendor fdisks.
It's not declared in the kernel, and thus no driver should implement it.

