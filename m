Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbVKCVHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVKCVHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbVKCVHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:07:54 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:36321 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1030482AbVKCVHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:07:53 -0500
Date: Thu, 03 Nov 2005 23:07:38 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [was Re: Linux 2.6.14 ] Revert
 "x86-64: Avoid unnecessary double bouncing for swiotlb"
In-reply-to: <200511031935.56160.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Andrew Morton <akpm@osdl.org>
Message-id: <20051103210738.GL31790@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
 <200510291214.34718.ak@suse.de> <20051031214859.GA3721@localhost.localdomain>
 <200511031935.56160.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 07:35:55PM +0100, Andi Kleen wrote:

> Anyways, with the dma_ops patch we can probably separate it cleanly
> and avoid the problem.

Hi Andi, Kiran, would something like:

#define PCI_DMA_BUS_IS_PHYS (mapping_ops->bus_is_phys) 

do the job, where mapping_ops->bus_is_phys is set to 0 for gart and
swiotlb, and 1 for nommu?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

