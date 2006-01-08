Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161215AbWAHVnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbWAHVnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWAHVnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:43:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161215AbWAHVnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:43:43 -0500
Date: Sun, 8 Jan 2006 13:43:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] mm: page refcount use atomic primitives
Message-Id: <20060108134327.63c3afeb.akpm@osdl.org>
In-Reply-To: <43C178D5.5010703@yahoo.com.au>
References: <20060108052307.2996.39444.sendpatchset@didi.local0.net>
	<20060108052342.2996.33981.sendpatchset@didi.local0.net>
	<20060107215413.560aa3a9.akpm@osdl.org>
	<43C178D5.5010703@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> > That's from a two-minute-peek.  I haven't thought about this dreadfully
>  > hard.  But I'd like to gain some confidence that you have, please.  This
>  > stuff is tricky.
>  > 
> 
>  Right, no blam. This is how I avoid taking the LRU lock.
> 
>    "Instead, use atomic_inc_not_zero to ensure we never **pick up a 0 refcount**
>     page from the LRU (ie. we guarantee the page will not be touched)."
> 
>  I don't understand what you're asking?

Well if you don't understand me, how do you expect me to?

Ho hum.  Please redo the patches into something which vaguely applies and
let's give them a spin.

I would prefer that the BUG_ONs be split into a separate patch tho.  Or at
least, let's take a real close look at whether they're really needed.
