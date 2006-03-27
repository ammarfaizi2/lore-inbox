Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWC0MYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWC0MYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 07:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWC0MYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 07:24:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36325 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750959AbWC0MYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 07:24:47 -0500
Date: Mon, 27 Mar 2006 14:24:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: swsusp shrink_all_memory tweaks
Message-ID: <20060327122415.GC1766@elf.ucw.cz>
References: <200603200231.50666.kernel@kolivas.org> <200603202250.14843.kernel@kolivas.org> <200603201946.32681.rjw@sisk.pl> <200603241807.41175.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603241807.41175.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > swsusp_shrink_memory() is still wrong, because it will always fail for
> > image_size = 0.  My bad, sorry.
> >
> > The appended patch (on top of yours) should fix that (hope I did it right
> > this time).
> 
> Well I discovered that if all the necessary memory is freed in one call to
>  shrink_all_memory we don't get the nice updating printout from
>  swsusp_shrink_memory telling us we're making progress. So instead of
>  modifying the function to call shrink_all_memory with the full amount (and
>  since we've botched swsusp_shrink_memory a few times between us), we should
>  limit it to a max of SHRINK_BITEs instead.
> 
>  This patch is fine standalone.
> 
>  Rafael, Pavel what do you think of this one? 

Looks good to me (but I'm not a mm expert).
									Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
