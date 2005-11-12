Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVKLU0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVKLU0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 15:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKLU0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 15:26:49 -0500
Received: from mailfe05.swip.net ([212.247.154.129]:64971 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S964776AbVKLU0s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 15:26:48 -0500
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Some debugging patches on top of -mm
From: Alexander Nyberg <alexn@telia.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051112031320.40543ae4.pj@sgi.com>
References: <20050905195001.GA10223@localhost.localdomain>
	 <20051112031320.40543ae4.pj@sgi.com>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 21:26:07 +0100
Message-Id: <1131827167.12287.5.camel@c213-100-52-74.swipnet.se>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch, known as page-owner-tracking-leak-detector.patch has
> apparently been sitting in Andrew's *-mm for the last two months.
> 
> I just noticed it now, when reading mm/page_alloc.c.
> 
> I'd like to know if the #ifdef's and CONFIG_PAGE_OWNER specific code
> can be removed from page_alloc.c, and put in a header file.  Ideally,
> you patch would add just one line to the __alloc_pages() code - a call
> to set_page_owner() that either became no code (a static inline empty
> function) or a call to your code, if this feature was CONFIG enabled.
> 
> The *.c files are where all the logic comes together, and it is vital
> to the long term readability of these files that we avoid #ifdef's in
> these files.  Any one feature can be ifdef'd in, with seeming little
> harm to the readability of the code (especially in the eyes of the
> author of that particular bit of ifdef'd code ;).  But imagine what
> a deity-awful mess these files would be if we had all been doing that
> over the years with our various favorite features.
> 

Yes, it was a quick hack when akpm said that he'd like a page tracking
mechanism. I said myself that I thought it was too ugly to go into
mainline. Later I tried to make it some kind of generic framework that
all arches could use but there was no interest.

If you wish to make it nicer/mergeable it's all yours.

