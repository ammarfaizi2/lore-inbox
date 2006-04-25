Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWDYFfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDYFfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWDYFfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:35:20 -0400
Received: from mtaout2.012.net.il ([84.95.2.4]:26802 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S932115AbWDYFfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:35:20 -0400
Date: Tue, 25 Apr 2006 08:33:02 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] mm: add a nopanic option for low bootmem
In-reply-to: <200604250043.38590.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org,
       muli@il.ibm.com
Message-id: <20060425053302.GD28558@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060424214428.GA14575@us.ibm.com> <200604250043.38590.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 12:43:38AM +0200, Andi Kleen wrote:
> On Monday 24 April 2006 23:44, Jon Mason wrote:
> > This patch adds a no panic option for low bootmem allocs.  This will
> > allow for a more graceful handling of "out of memory" for those
> > callers who wish to handle it.
> 
> What's the user of it? Normally we don't merge such changes without
> an user.

Calgary and swiotlb can use it to gracefully handle out of memory when
they allocate their aperture (swiotlb) or translation tables (Calgary)
on initialization. Either can fall back to no-iommu if initialization
fails so there's really no need to panic.

Jon, you should probably resubmit this with your swiotlb patches
making use of it.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

