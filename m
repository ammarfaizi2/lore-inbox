Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbVHKEo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbVHKEo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVHKEo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:44:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932251AbVHKEo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:44:58 -0400
Date: Thu, 11 Aug 2005 14:44:41 +1000
From: Andrew Morton <akpm@osdl.org>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: mel@csn.ul.ie, linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
Message-Id: <20050811144441.54b6ef4a.akpm@osdl.org>
In-Reply-To: <aec7e5c30508102008b739a6c@mail.gmail.com>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
	<20050808160844.04d1f7ac.akpm@osdl.org>
	<Pine.LNX.4.58.0508101730441.11984@skynet>
	<20050810101714.147e1333.akpm@osdl.org>
	<aec7e5c30508102008b739a6c@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus.damm@gmail.com> wrote:
>
> On 8/11/05, Andrew Morton <akpm@osdl.org> wrote:
> > Mel Gorman <mel@csn.ul.ie> wrote:
> > > The majority of pages I am seeing no longer have page->mapping set. Does
> > > this mean they are in the process of being cleared up?
> > 
> > They're just anonymous pages, aren't they?  But you said "pages that are
> > being used for inodes".  Confused.
> 
> I thought page->mapping was used by rmap for both inode-backed and
> anonymous pages. And the PAGE_MAPPING_ANON bit was used to determine
> that page->mapping points to struct anon_vma instead of struct
> address_space.
> 
> When is page->mapping NULL?
> 

mm.h:page_mapping() handles all that.
