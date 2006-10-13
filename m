Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWJMVAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWJMVAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWJMVAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:00:24 -0400
Received: from vena.lwn.net ([206.168.112.25]:1990 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751913AbWJMVAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:00:23 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] Add __GFP_ZERO to GFP_LEVEL_MASK 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Fri, 13 Oct 2006 13:46:35 PDT."
             <20061013134635.a983e4d7.akpm@osdl.org> 
Date: Fri, 13 Oct 2006 15:00:22 -0600
Message-ID: <30805.1160773222@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> It would be a bit odd to pass __GFP_ZERO into the slab allocator.  Slab
> doesn't need that hint: it has its own ways of initialising the memory.
> 
> What is the callsite?

It's vmalloc_user(), which does this:

  ret = __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);

jon
