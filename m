Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVANJev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVANJev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVANJev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:34:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:7909 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261928AbVANJes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:34:48 -0500
Date: Fri, 14 Jan 2005 01:34:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       rusty@rustcorp.com.au, dipankar@in.ibm.com
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-Id: <20050114013425.77ad7c3f.akpm@osdl.org>
In-Reply-To: <20050114150519.GA3189@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com>
	<20050113005730.0e10b2d9.akpm@osdl.org>
	<20050114150519.GA3189@impedimenta.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> Just out of curiosity, is bubble 
>  sort unpopular or having two sort functions in the kernel source tree an
>  issue here?

yes and yes ;)

>  > 
>  > Why cannot the code simply call vmalloc rather than copying its internals?
> 
>  Node local allocation. vmalloc cannot ensure pages for correspomding
>  cpus are node local.  Also, design goal was to allocate pages for 
>  cpu_possible cpus only.  With plain vmalloc, we will end up allocating 
>  pages for NR_CPUS.

So...  is it not possible to enhance vmalloc() for node-awareness, then
just use it?

