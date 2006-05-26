Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWEZJlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWEZJlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 05:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWEZJlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 05:41:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:39390 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751364AbWEZJlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 05:41:31 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [discuss] Re: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction into the callers
Date: Fri, 26 May 2006 11:35:36 +0200
User-Agent: KMail/1.9.1
Cc: discuss@x86-64.org, Muli Ben-Yehuda <mulix@mulix.org>,
       Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20060525033550.GD7720@us.ibm.com> <200605260957.02163.ak@suse.de> <4476C27A.7040707@garzik.org>
In-Reply-To: <4476C27A.7040707@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261135.36509.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > On the other hand if the problem of passing wrong parameters here
> > isn't common I would be ok with dropping them.
> 
> As the author noted, it was only used in early platform bring-up.  And 
> simply reviewing the patch... it is clear that screwing up the 
> parameters would cause massive, noticeable problems immediately -- such 
> as on EM64T with swiotlb.

Well the point is that even if you don't run on swiotlb
(which most people even on EM64T don't use because they don't have more than
3GB of RAM) you won't screw them up.

On the other hand correct IOMMU operation needs much more than passing
these parameters so only checking for this might not be very useful.

BTW we've had these checks forever - Jon just moved them to a different place.
But they indeed might have outlived their usefulness.

-Andi
