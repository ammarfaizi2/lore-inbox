Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVBGOaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVBGOaK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVBGO2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:28:53 -0500
Received: from gprs215-44.eurotel.cz ([160.218.215.44]:34206 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261433AbVBGO1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:27:43 -0500
Date: Mon, 7 Feb 2005 15:27:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Message-ID: <20050207142706.GD8040@elf.ucw.cz>
References: <200501310019.39526.rjw@sisk.pl> <200502071208.50001.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502071208.50001.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The following patch is (yet) an(other) attempt to eliminate the need for using higher
> > order memory allocations on resume.  It accomplishes this by replacing the array
> > of page backup entries with a list, so it is only necessary to allocate individual
> > memory pages.  This approach makes it possible to avoid relocating many memory
> > pages on resume (as a result, much less memory is used) and to simplify
> > the assembly code that restores the image.
> 
> I have updated the resume patch to apply to the 2.6.11-rc3-mm1 kernel that
> contains the suspend part and the x86_64-Speed-up-suspend patch.  The patch
> is only for x86-64 and i386.
> 
> [Note: without this patch the resume process fails on my box ("out of memory")
> during every 7th - 8th suspend/resume cycle, on the average.]

Pssst. At this point, solution would be to revert the first part,
too. 2.6.11 is too near to do anything else.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
