Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUKICgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUKICgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUKICgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:36:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:5862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261354AbUKICgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:36:02 -0500
Date: Mon, 8 Nov 2004 18:35:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /
 all_unreclaimable braindamage
Message-Id: <20041108183552.7caccad1.akpm@osdl.org>
In-Reply-To: <419029D9.90506@cyberone.com.au>
References: <20041105200118.GA20321@logos.cnet>
	<20041108162731.GE2336@logos.cnet>
	<20041108185546.GA3468@logos.cnet>
	<419029D9.90506@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> I'm not sure... it could also be just be a fluke
>  due to chaotic effects in the mm, I suppose :|

2.6 scans less than 2.4 before declaring oom.  I looked at the 2.4
implementation and thought "whoa, that's crazy - let's reduce it and see
who complains".  My three-year-old memory tells me it was reduced by 2x to
3x.

We need to find testcases (dammit) and do the analysis.  It could be that
we're simply not scanning far enough.
