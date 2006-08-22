Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWHVBYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWHVBYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 21:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWHVBYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 21:24:52 -0400
Received: from smtp-out.google.com ([216.239.45.12]:30557 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932077AbWHVBYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 21:24:51 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=SZ7a7OvEJ0xMZC9g/sWDOUNqqO8xcOzdDnWranj9RICirSDHu0sI0+zk+C/Sx1GRc
	ji12HmlkGW5Jy2TWepPUw==
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
In-Reply-To: <44E98E61.2030608@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>
	 <1155834136.14617.29.camel@galaxy.corp.google.com> <44E58A89.8040001@sw.ru>
	 <1155920158.22899.8.camel@galaxy.corp.google.com> <44E98E61.2030608@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 21 Aug 2006 18:23:32 -0700
Message-Id: <1156209812.11127.20.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 14:43 +0400, Kirill Korotaev wrote:
> >>1. reclaiming user resources is not that good idea as it looks to you.
> >>such solutions end up with lots of resources spent on reclaim.
> >>for user memory reclaims mean consumption of expensive disk I/O bandwidth
> >>which reduces overall system throughput and influences other users.
> >>
> > 
> > 
> > May be I'm overlooking something very obvious.  Please tell me, what
> > happens when a user hits a page fault and the page allocator is easily
> > able to give a page from its pcp list.  But container is over its limit
> > of physical memory.  In your patch there is no attempt by container
> > support to see if some of the user pages are easily reclaimable.  What
> > options a user will have to make sure some room is created.
> The patch set send doesn't control user memory!
> This topic is about kernel memory...
> 


And that is why I asked the question in the very first mail (if this
support is going to come later).

-rohit

