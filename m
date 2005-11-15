Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVKOJD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVKOJD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 04:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKOJD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 04:03:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56285 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751389AbVKOJD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 04:03:58 -0500
Date: Tue, 15 Nov 2005 01:03:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Simon.Derr@bull.net, clameter@sgi.com, rohit.seth@intel.com
Subject: Re: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
Message-Id: <20051115010303.6bc04222.akpm@osdl.org>
In-Reply-To: <4379A399.1080407@yahoo.com.au>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
	<20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
	<4379A399.1080407@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Paul Jackson wrote:
> > Rationalize mm/page_alloc.c:__alloc_pages() ALLOC flag names.
> > 
> 
> I don't really see the need for this. The names aren't
> clearly better, and the downside is that they move away
> from the terminlogy we've been using in the page allocator
> for the past few years.

I thought they were heaps better, actually.

-#define ALLOC_NO_WATERMARKS	0x01 /* don't check watermarks at all */
-#define ALLOC_HARDER		0x02 /* try to alloc harder */
-#define ALLOC_HIGH		0x04 /* __GFP_HIGH set */
+#define ALLOC_DONT_DIP	0x01 	/* don't dip into memory reserves */
+#define ALLOC_DIP_SOME	0x02 	/* dip into reserves some */
+#define ALLOC_DIP_ALOT	0x04 	/* dip into reserves further */
+#define ALLOC_MUSTHAVE	0x08 	/* ignore all constraints */

very explicit.
