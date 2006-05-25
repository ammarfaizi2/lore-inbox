Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWEYJmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWEYJmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 05:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWEYJmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 05:42:49 -0400
Received: from mtaout4.012.net.il ([84.95.2.10]:35925 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S965099AbWEYJms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 05:42:48 -0400
Date: Thu, 25 May 2006 12:42:36 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction into
 the callers
In-reply-to: <447533FB.1080400@garzik.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jon Mason <jdmason@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Message-id: <20060525094236.GB22495@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060525033550.GD7720@us.ibm.com> <447533FB.1080400@garzik.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 12:35:07AM -0400, Jeff Garzik wrote:
> Jon Mason wrote:
> >>From Andi Kleen's comments on the original Calgary patch, move
> >valid_dma_direction into the calling functions.
> >
> >Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
> >Signed-off-by: Jon Mason <jdmason@us.ibm.com>
> 
> Even though BUG_ON() includes unlikely(), this introduces additional 
> tests in very hot paths.

Are they really very hot? I mean if you're calling the DMA API, you're
about to frob the hardware or have already frobbed it - does this
check really matter?

> _Why_ do we need this at all?

It was helpful for us during the dma-ops work and Calgary bringup and
Andi requested that we move it from Calgary to common code. I think
we're fine with dropping it if that's the consensus, but it did catch
a few bugs early on and the cost is tiny.

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

