Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVDCUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVDCUGH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVDCUGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 16:06:07 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:22450 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261893AbVDCUF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 16:05:58 -0400
Date: Sun, 3 Apr 2005 21:05:57 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AIM9 slowdowns between 2.6.11 and 2.6.12-rc1 (probably false
 positive)
In-Reply-To: <1112555170.7189.34.camel@localhost>
Message-ID: <Pine.LNX.4.58.0504032059520.1402@skynet>
References: <Pine.LNX.4.58.0504031532570.25594@skynet> <1112555170.7189.34.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005, Dave Hansen wrote:

> On Sun, 2005-04-03 at 15:37 +0100, Mel Gorman wrote:
> > While testing the page placement policy patches on 2.6.12-rc1, I noticed
> > that aim9 is showing significant slowdowns on page allocation-related
> > tests. An excerpt of the results is at the end of this mail but it shows
> > that page_test is allocating 18000 less pages.
> >
> > I did not check who has been recently changing the buddy allocator but
> > they might want to run a benchmark or two to make sure this is not
> > something specific to my setup.
>
> Can you get some kernel profiles to see what, exactly, is causing the
> decreased performance?  Also, what kind of system do you have?  Does
> backing this out help?  If not, can you test some BK snapshots to see
> when this started occurring?
>
> http://linus.bkbits.net:8080/linux-2.5/cset@422de02c1628MP_noKSum9sGlTaC-Q
>

The machine is a quad xeon with P III 733 processors. I don't have profile
information available as I wasn't collecting as I went along. However,
backing out the patch made little difference

However, I reran the test on 2.6.11 and this time the performance
difference was a lot less. Something else must have been happening when I
collected the first set of poor results. I'll revisit this when I'm next
working on kernel stuff and see can I reproduce it again reliably.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
