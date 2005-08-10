Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVHJRyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVHJRyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVHJRyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:54:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965238AbVHJRyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:54:12 -0400
Date: Wed, 10 Aug 2005 10:52:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
Message-Id: <20050810105253.58d8bf0f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508101845190.11984@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
	<20050808160844.04d1f7ac.akpm@osdl.org>
	<Pine.LNX.4.58.0508101730441.11984@skynet>
	<20050810101714.147e1333.akpm@osdl.org>
	<Pine.LNX.4.58.0508101819340.11984@skynet>
	<20050810104044.1e0da3e6.akpm@osdl.org>
	<Pine.LNX.4.58.0508101845190.11984@skynet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> > Well there are conditions in which mmapped file pages can get converted to
> > anonymous pages due to truncate(), but I have a feeling that we stopped
> > that from happening.
> >
> 
> Does that also apply to when a file is unlinked rather than truncated?

Yup.  unlink() does truncate if it unlinked the final link.

> In case it is journalling-related, I am going to rerun the tests on an
> ext2 filesystem over the weekend.

Good idea.

