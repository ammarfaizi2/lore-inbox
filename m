Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266381AbUHCNbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUHCNbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 09:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUHCNbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 09:31:19 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51107 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266381AbUHCNbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 09:31:15 -0400
Date: Tue, 3 Aug 2004 15:30:35 +0200
From: Jens Axboe <axboe@suse.de>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Steve Snyder <swsnyder@insightbb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-ID: <20040803133034.GM23504@suse.de>
References: <200408021602.34320.swsnyder@insightbb.com> <20040802220521.GA2179@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802220521.GA2179@ip68-4-98-123.oc.oc.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2004, Barry K. Nathan wrote:
> On Mon, Aug 02, 2004 at 04:02:34PM -0500, Steve Snyder wrote:
> > There seems to be a controversy about the use of the CONFIG_HIGHMEM4G  
> > kernel configuration.  After reading many posts on the subject, I still 
> > don't know which setting is best for me.
> 
> On my own desktop system with 1GB RAM, any highmem slowdown seems to be
> outweighed by the fact that more disk data stays cached in RAM (so I hit
> the disk much less often).

There's also the option of moving the mapping only slightly, so that all
of the 1G fits in low memory. That's the best option for 1G desktop
machines, imho. Changing PAGE_OFFSET from 0xc0000000 to 0xb0000000 would
probably be enough.

Then you can have your cake and eat it too.

-- 
Jens Axboe

