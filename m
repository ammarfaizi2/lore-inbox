Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVHKFoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVHKFoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVHKFoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:44:04 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:47367 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932216AbVHKFoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:44:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O4NitJr/GBPyB5unRiMTUd6nRium7+G7Z4JVhKz5OR6uq87Jn3D9wFTZME1ejOIBbieCqLuAiO0aNSMaVT4n05WeLLY1b9UWQQsfChOWfzu1qkIYyLnDlDGRU+pLSkv0po5eM1rxbRgC69fV5JSyChdYI9kc9X6cInkM6RLv+pE=
Message-ID: <aec7e5c305081022436c37204e@mail.gmail.com>
Date: Thu, 11 Aug 2005 14:43:59 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: How to reclaim inode pages on demand
Cc: mel@csn.ul.ie, linux-kernel@vger.kernel.org
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

Yes, thanks, but I believe that page->mapping is never NULL for
anonymous pages. Does not all anonymous pages have page->mapping
pointing to struct anon_vma?

/ magnus
