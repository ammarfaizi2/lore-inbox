Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWIVQDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWIVQDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWIVQDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:03:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932308AbWIVQDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:03:45 -0400
Date: Fri, 22 Sep 2006 09:03:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: 2.6.19 -mm merge plans (ecryptfs)
Message-Id: <20060922090337.ed835b06.akpm@osdl.org>
In-Reply-To: <20060922144233.GA25478@infradead.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<20060922144233.GA25478@infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 15:42:33 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> > ecryptfs-versioning-fixes-tidy.patch
> > 
> >  Will fold into a single patch and will then merge.
> 
> Please add a
> 
> Not-Acked-By: Christoph Hellwig <hch@lst.de>
> 
> here as you don't seem to listen to any of the comments I had against
> the current state and I want this clearly documented.

I thought everything got addressed, apart from

 - please split all the generic stackable filesystem passthorugh routines
   into a separated stackfs layer, in a few files in fs/stackfs/ that
   you depend on.  They'll get _GPL exported to all possible stackable
   filesystem.  They'll need their own store underlying object helpers,
   but that can be made to work by embedding the generic stackfs data
   as first thing in the ecryptfs object.

which seemed rather a lot to ask.
