Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVHKJJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVHKJJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 05:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVHKJJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 05:09:38 -0400
Received: from nproxy.gmail.com ([64.233.182.194]:27332 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030235AbVHKJJh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 05:09:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=afH9w5OKMOV3pHTQdkoQs21A3IjYWi8FzQPVbpuo80XOybqkQ4Z5J8I9/aJApaFF0UZ8RO7ic8r3whvRRkrHDRZ/Sg+p28uOQyWpGWW59RzbkkQRyIq+t6kjHnOP8OFYyz48iG0iod+FLHtvE4uP5Oi/LJ+l74NFKo+Y+T+ZW/4=
Message-ID: <2cd57c900508110209de388f2@mail.gmail.com>
Date: Thu, 11 Aug 2005 17:09:31 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: How to reclaim inode pages on demand
Cc: Magnus Damm <magnus.damm@gmail.com>, mel@csn.ul.ie,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050811144441.54b6ef4a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
	 <20050808160844.04d1f7ac.akpm@osdl.org>
	 <Pine.LNX.4.58.0508101730441.11984@skynet>
	 <20050810101714.147e1333.akpm@osdl.org>
	 <aec7e5c30508102008b739a6c@mail.gmail.com>
	 <20050811144441.54b6ef4a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Andrew Morton <akpm@osdl.org> wrote:
> Magnus Damm <magnus.damm@gmail.com> wrote:
> >
> > On 8/11/05, Andrew Morton <akpm@osdl.org> wrote:
> > > Mel Gorman <mel@csn.ul.ie> wrote:
> > > > The majority of pages I am seeing no longer have page->mapping set. Does
> > > > this mean they are in the process of being cleared up?
> > >
> > > They're just anonymous pages, aren't they?  But you said "pages that are
> > > being used for inodes".  Confused.
> >
> > I thought page->mapping was used by rmap for both inode-backed and
> > anonymous pages. And the PAGE_MAPPING_ANON bit was used to determine
> > that page->mapping points to struct anon_vma instead of struct
> > address_space.
> >
> > When is page->mapping NULL?
> >
> 
> mm.h:page_mapping() handles all that.

at http://sosdg.org/~coywolf/lxr/source/include/linux/mm.h#L561
Should the comment be s/page_mapped/page->mapping/ ?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
