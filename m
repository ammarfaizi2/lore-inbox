Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVBGOvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVBGOvf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVBGOtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:49:16 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:25992 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261440AbVBGOoj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:44:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: do not use higher order allocations on resume [update 2]
Date: Mon, 7 Feb 2005 15:45:27 +0100
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Hu Gang <hugang@soulinfo.com>
References: <200501310019.39526.rjw@sisk.pl> <200502071208.50001.rjw@sisk.pl> <20050207142706.GD8040@elf.ucw.cz>
In-Reply-To: <20050207142706.GD8040@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502071545.27613.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 7 of February 2005 15:27, Pavel Machek wrote:
> Hi!
> 
> > > The following patch is (yet) an(other) attempt to eliminate the need for using higher
> > > order memory allocations on resume.  It accomplishes this by replacing the array
> > > of page backup entries with a list, so it is only necessary to allocate individual
> > > memory pages.  This approach makes it possible to avoid relocating many memory
> > > pages on resume (as a result, much less memory is used) and to simplify
> > > the assembly code that restores the image.
> > 
> > I have updated the resume patch to apply to the 2.6.11-rc3-mm1 kernel that
> > contains the suspend part and the x86_64-Speed-up-suspend patch.  The patch
> > is only for x86-64 and i386.
> > 
> > [Note: without this patch the resume process fails on my box ("out of memory")
> > during every 7th - 8th suspend/resume cycle, on the average.]

Well, this doesn't depend on the previous patch, apparently. ;-)
 
> Pssst. At this point, solution would be to revert the first part,
> too. 2.6.11 is too near to do anything else.

Oh, I didn't mean changing anything now (eg because of the missing ppc
assembly part).  However, the patch is useful for me so I thought I'd post it
in case someone else (using the -mm kernels) needed it.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
