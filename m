Return-Path: <linux-kernel-owner+w=401wt.eu-S965277AbXAHAya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965277AbXAHAya (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 19:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbXAHAya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 19:54:30 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:53054 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbXAHAy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 19:54:29 -0500
Date: Mon, 8 Jan 2007 00:54:27 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Christoph Hellwig <hch@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
       Zachary Amsden <zach@vmware.com>,
       Jeremy Fitzhardinge <jeremy@xensource.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
In-Reply-To: <20070107183946.GB8158@infradead.org>
Message-ID: <Pine.LNX.4.64.0701080052400.1019@skynet.skynet.ie>
References: <20070106000715.GA6688@elte.hu> <459EEDEB.8090800@vmware.com>
 <1168064710.20372.28.camel@localhost.localdomain> <20070106071424.GB11232@elte.hu>
 <1168100325.20372.37.camel@localhost.localdomain> <20070106193152.GA26153@infradead.org>
 <20070107183946.GB8158@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Even better we can actualy avid most of the page table walks completely.
> First there is a number of places that can never have the vmalloc case
> an may use ioremap/iounmap directly.  Secondly drm_core_ioremap/
> drm_core_ioremapfree already have the right drm_map to check wich kind
> of mapping we have - we just need to use it instead of discarding that
> information!  The only leaves direct drm_ioremapfree in i810_dma.c and
> i830_dma.c which I don't quite manage to follow.  Maybe Dave has an
> idea how to get rid of those aswell.
>

I've applied two patches to the DRM git
http://gitweb.freedesktop.org/?p=mesa/drm.git;a=summary

They need a fair bit of testing, I've tested them no i810, but I need to 
test them on a few other boards before I'd consider putting them in -mm..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

