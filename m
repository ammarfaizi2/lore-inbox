Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbVKEHRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbVKEHRw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKEHRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:17:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64175 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751278AbVKEHRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:17:52 -0500
Date: Fri, 4 Nov 2005 23:17:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-Id: <20051104231741.2e7c39af.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511050604040.26716@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
	<20051104213225.39d4c2a3.akpm@osdl.org>
	<Pine.LNX.4.61.0511050604040.26716@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> I'm happy for people to use page->private again.  I thought we
>  ought to try out this minimal patch first, for reassurance that the
>  arches are not using those fields of a pagetable struct page; but that
>  once it's had some exposure, we'd revert the page_private mods elsewhere.
>  There's no point to that wrapper with the union gone, is there?

I'd be inclined to leave it there - we wrap access to most of the rest of
struct page.  It might come in handy for the next brainwave - dunno.
