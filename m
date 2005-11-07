Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVKGAAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVKGAAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 19:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVKGAAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 19:00:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932371AbVKGAAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 19:00:18 -0500
Date: Sun, 6 Nov 2005 16:00:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-Id: <20051106160008.28822bbd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511062348240.29944@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
	<20051106112838.0d524f65.akpm@osdl.org>
	<Pine.LNX.4.61.0511062245240.29625@goblin.wat.veritas.com>
	<20051106151326.63cf16bd.akpm@osdl.org>
	<Pine.LNX.4.61.0511062348240.29944@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Suppress split ptlock on arches which may use one page for multiple page
>  tables.  Reconsider what better to do (particularly on ppc64) later on.

But why is that a problem per-se?  A few "pagetable pages" will share the
same lock.  Deadlocky when we take two pagetable locks?

The code ran OK on ppc64, fwiw.

