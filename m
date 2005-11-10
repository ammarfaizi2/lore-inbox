Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVKJMwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVKJMwB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKJMwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:52:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbVKJMv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:51:59 -0500
Date: Thu, 10 Nov 2005 04:51:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-Id: <20051110045144.40751a42.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com>
	<20051109181022.71c347d4.akpm@osdl.org>
	<Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com>
	<20051109185645.39329151.akpm@osdl.org>
	<20051110120624.GB32672@elte.hu>
	<Pine.LNX.4.61.0511101233530.6896@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Thu, 10 Nov 2005, Ingo Molnar wrote:
> > 
> > yuck. What is the real problem btw? AFAICS there's enough space for a 
> > 2-word spinlock in struct page for pagetables.
> 
> Yes.  There is no real problem.  But my patch offends good taste.
> 

Isn't it going to overrun page.lru with CONFIG_DEBUG_SPINLOCK?
