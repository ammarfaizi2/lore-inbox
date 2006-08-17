Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWHQRDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWHQRDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWHQRDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:03:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:7833 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965056AbWHQRDr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:03:47 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=nPZtFW0BKMjilRGj5Fmwy/SmyxWvQAq4ujpPuGr10lMbtqHKW0c/GzkpHccjfKKO9
	Ack6uZNusoHWu2e3sbDvw==
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
In-Reply-To: <44E46ED3.7000201@sw.ru>
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>
	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 17 Aug 2006 10:02:16 -0700
Message-Id: <1155834136.14617.29.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 17:27 +0400, Kirill Korotaev wrote:
> > If I'm reading this patch right then seems like you are making page
> > allocations to fail w/o (for example) trying to purge some pages from
> > the page cache belonging to this container.  Or is that reclaim going to
> > come later?
> 
> charged kernel objects can't be _reclaimed_. how do you propose
> to reclaim tasks page tables or files or task struct or vma or etc.?


I agree that kernel objects cann't be reclaimed easily.  But what you
are proposing is also not right.  Returning failure w/o doing any
reclaim on pages (that are reclaimable) is not useful.  And this is why
I asked, is this change going to be part of next set of patches (as
current set of patches are only tracking kernel usage).

-rohit

