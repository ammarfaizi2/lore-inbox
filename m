Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWCTWej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWCTWej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWCTWej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:34:39 -0500
Received: from bhhdoa.org.au ([65.98.99.88]:55560 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S1751316AbWCTWeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:34:37 -0500
Message-ID: <1142889937.441f1dd19e90f@vds.kolivas.org>
Date: Tue, 21 Mar 2006 08:25:37 +1100
From: kernel@kolivas.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       linux-mm@kvack.org
Subject: Re: [PATCH][3/3] mm: swsusp post resume aggressive swap prefetch
References: <200603200234.01472.kernel@kolivas.org> <200603202247.38576.rjw@sisk.pl>
In-Reply-To: <200603202247.38576.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Rafael J. Wysocki" <rjw@sisk.pl>:

> Hi,
> 
> On Sunday 19 March 2006 16:34, Con Kolivas wrote:
> > 
> > Swsusp reclaims a lot of memory during the suspend cycle and can benefit
> > from the aggressive_swap_prefetch mode immediately upon resuming.
> 
> It slows down the resume on my box way too much.  Last time it took 10x more
> time than actually reading the image.
> 
> I think the problem is for the userland suspend (which I use) it's done too
> early,
> when the image pages are still in the swap, so they are taken into
> consideration
> by the aggressive prefetch.  If that really is the case, the solution would
> be to
> trigger the aggressive prefetch from the userland, if needed, after the
> image
> pages have been released.

I assume this is unique to the userland resume as the in-kernel resume is not
slowed down? If so, is there a way to differentiate the two so we only
aggressively prefetch on kernel resume - is that what you meant by doing it in
the other file?

Cheers,
Con

