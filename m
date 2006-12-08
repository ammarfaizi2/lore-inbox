Return-Path: <linux-kernel-owner+w=401wt.eu-S1947439AbWLHWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947439AbWLHWPA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 17:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947437AbWLHWPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 17:15:00 -0500
Received: from mga03.intel.com ([143.182.124.21]:40880 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947439AbWLHWO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 17:14:59 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,515,1157353200"; 
   d="scan'208"; a="155806842:sNHT17593905"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <jens.axboe@oracle.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] speed up single bio_vec allocation
Date: Fri, 8 Dec 2006 14:14:58 -0800
Message-ID: <000001c71b16$4ca91b90$d134030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccZHnIaAavjHH94QdmLo2Oe1qdRtAAQicDwAG0U6sA=
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Chen, Kenneth wrote on Wednesday, December 06, 2006 10:20 AM
> > Jens Axboe wrote on Wednesday, December 06, 2006 2:09 AM
> > This is what I had in mind, in case it wasn't completely clear. Not
> > tested, other than it compiles. Basically it eliminates the small
> > bio_vec pool, and grows the bio by 16-bytes on 64-bit archs, or by
> > 12-bytes on 32-bit archs instead and uses the room at the end for the
> > bio_vec structure.
> 
> Yeah, I had a very similar patch queued internally for the large benchmark
> measurement.  I will post the result as soon as I get it.


Jens, this improves 0.25% on our db transaction processing benchmark setup.
The patch tested is (on top of 2.6.19):
http://marc.theaimsgroup.com/?l=linux-kernel&m=116539972229021&w=2

- Ken
