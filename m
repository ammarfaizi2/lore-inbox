Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269691AbUIRXs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269691AbUIRXs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269692AbUIRXsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:48:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43160 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269691AbUIRXrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:47:40 -0400
Date: Sat, 18 Sep 2004 19:47:19 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] xattr consolidation v2 - generic xattr API
In-Reply-To: <200409190131.01625.agruen@suse.de>
Message-ID: <Xine.LNX.4.44.0409181943030.12816-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Andreas Gruenbacher wrote:

> This currently is only relevant for the security attribute. Selinux always 
> returns the same attribute name so it can't trigger this problem, but other 
> LSMs might do something different.
> 
> We can add a list_size parameter to xattr_handler->list to get this fixed. We 
> should change the name_len parameter of xattr_handler->list from int to 
> size_t:

Ahh, I thought we had the inode semaphore (never trust documentation).  
Why don't we take that instead in listxattr() ?  The name_len thing seems 
kludgy.

> I also noticed that your additions to fs/xattr.c use a slightly different 
> coding style than the rest of the file. You might want to change that as 
> well.

I was using Linus-recommended coding style, but it can be changed I guess.


- James
-- 
James Morris
<jmorris@redhat.com>


