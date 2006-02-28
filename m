Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWB1BAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWB1BAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWB1BAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:00:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65422 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751067AbWB1BAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:00:35 -0500
Date: Mon, 27 Feb 2006 16:59:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: clameter@engr.sgi.com, largret@gmail.com, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060227165921.242f6810.akpm@osdl.org>
In-Reply-To: <20060228004115.GA37362@muc.de>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	<20060226102152.69728696.akpm@osdl.org>
	<1140988015.5178.15.camel@shogun.daga.dyndns.org>
	<20060226133140.4cf05ea5.akpm@osdl.org>
	<20060226235142.GB91959@muc.de>
	<Pine.LNX.4.64.0602271429270.12204@schroedinger.engr.sgi.com>
	<20060228004115.GA37362@muc.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> On Mon, Feb 27, 2006 at 02:30:02PM -0800, Christoph Lameter wrote:
> > On Sun, 27 Feb 2006, Andi Kleen wrote:
> > 
> > > Thinking about this more I think we need a __GFP_NOOOM for other
> > > purposes too. e.g. the x86-64 IOMMU code tries to do similar
> > > fallbacks and I suspect it will be hit by the OOM killer too.
> > 
> > Isnt this also a constrained allocation? We could expand the check to also 
> > catch these types of restrictions and fail.
> 
> No, it uses the full fallback zone list of the target node, not a custom
> one. Would be hard to detect without a flag.
> 
> Maybe __GFP_NORETRY is actually good enough for this purpose. Opinions?
> 

I was thinking that your __GFP_NOOOM was a thinko.  How would it differ
from __GFP_NORETRY?
