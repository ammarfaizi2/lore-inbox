Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264704AbSJOPf2>; Tue, 15 Oct 2002 11:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSJOPf2>; Tue, 15 Oct 2002 11:35:28 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:57250 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264704AbSJOPfY>; Tue, 15 Oct 2002 11:35:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Jens Axboe <axboe@suse.de>, Joe Thornber <joe@fib011235813.fsnet.co.uk>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Date: Tue, 15 Oct 2002 10:06:09 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <20021015103427.GH5294@suse.de> <02101509523700.05920@boiler>
In-Reply-To: <02101509523700.05920@boiler>
MIME-Version: 1.0
Message-Id: <02101510060901.05920@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 09:52, Kevin Corry wrote:
> Also, am I correct in assuming that for merge_bvec_fn() to work properly, a
> driver's merge_bvec_fn() must also call the merge_bvec_fn() of the driver
> below it? For example, lets say we have a DM linear device that maps to two
> underlying devices (or in LVM-speak, a linear LV that spans two PVs), both
> of which are MD RAID-1 devices. For a given large request, DM may decide
> that it is fully contained within one of its two target devices, and allow
> all the requested pages to be added to the bio. However, it also needs to
> ask MD what its limits are for that request, or MD would still have to go
> through the trouble to split up the bio after it has been submitted.

This example actually should have been RAID-0 (striping), not RAID-1 
(mirroring). Sorry if this caused any confusion.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
