Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbVI1Gsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbVI1Gsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVI1Gsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:48:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751058AbVI1Gso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:48:44 -0400
Date: Tue, 27 Sep 2005 23:47:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi)
Cc: clameter@engr.sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       alokk@calsoftinc.com
Subject: Re: 2.6.14-rc2 early boot OOPS (mm/slab.c:1767)
Message-Id: <20050927234744.7ddb9f67.akpm@osdl.org>
In-Reply-To: <20050928063017.GI1046@vega.lnet.lut.fi>
References: <20050927202858.GG1046@vega.lnet.lut.fi>
	<Pine.LNX.4.62.0509271630050.11040@schroedinger.engr.sgi.com>
	<20050928063017.GI1046@vega.lnet.lut.fi>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi) wrote:
>
>  On Tue, Sep 27, 2005 at 04:35:54PM -0700, Christoph Lameter wrote:
>  > On Tue, 27 Sep 2005, Tomi Lapinlampi wrote:
>  > 
>  > > I'm getting the following OOPS with 2.6.14-rc2 on an Alpha.
>  > 
>  > Hmmm. I am not familiar with Alpha. The .config looks as if this is a 
>  > uniprocessor configuration? No NUMA? 
> 
>  This is a simple uniprocessor configuration, no NUMA, no SMP. 

It might be due to the indev_of()-doesn't-get-inlined problem.  I'm not
sure what the symptoms of that were.  Please try
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.14-rc2-git6.gz
which has fixes.
