Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbVAQWi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbVAQWi3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbVAQWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:24:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:21456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262949AbVAQWLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:11:42 -0500
Date: Mon, 17 Jan 2005 14:11:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       rusty@rustcorp.com.au, dipankar@in.ibm.com
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-Id: <20050117141117.4606b58a.akpm@osdl.org>
In-Reply-To: <20050117182735.GA2322@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com>
	<20050113005730.0e10b2d9.akpm@osdl.org>
	<20050114150519.GA3189@impedimenta.in.ibm.com>
	<20050114013425.77ad7c3f.akpm@osdl.org>
	<20050117182735.GA2322@impedimenta.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
>  > So...  is it not possible to enhance vmalloc() for node-awareness, then
>  > just use it?
>  > 
> 
>  Memory for block management (free lists, bufctl lists) is also resident 
>  in one block.  A typical block in this allocator looks like this:
> 

I still don't get it.  It is possible to calculate the total size of the
block beforehand, yes?  So why not simply vmalloc_numa() a block of that
size then populate it?
