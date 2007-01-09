Return-Path: <linux-kernel-owner+w=401wt.eu-S932386AbXAIU2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbXAIU2r (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 15:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbXAIU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 15:28:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2860 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932386AbXAIU2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 15:28:46 -0500
Date: Tue, 9 Jan 2007 21:28:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Malte =?iso-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>,
       reiserfs-dev@namesys.com
Subject: Re: 2.6.20-rc4: known unfixed regressions (v2)
Message-ID: <20070109202850.GO25007@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> <20070109052510.GG25007@stusta.de> <Pine.LNX.4.64.0701090944070.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0701090944070.3594@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 09:58:19AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 9 Jan 2007, Adrian Bunk wrote:
> > 
> > Subject : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs) 
> > References : http://lkml.org/lkml/2007/1/7/117
> > Submitter : Malte Schröder <MalteSch@gmx.de>
> > Status : unknown
> 
> Adrian, this is also available as
> 
> 	http://lkml.org/lkml/2007/1/5/308

The latter was in my list as:

Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Patch      : http://lkml.org/lkml/2007/1/7/201
Status     : patch available

>...
> So I think this does show some confusion in reiserfs, but it's not 
> anything new. The only new thing is that the _message_ happens.
> 
> So I don't personally consider this a regression. Just a sign of old and 
> preexisting confusion that is now uncovered by new code (and it will print 
> out the scary message at most four times, and then stop complaining about 
> it. So apart from the scary message, nothing new and bad has really 
> happened).

At least the printing of scary messages is a regression.

Unless we want to be buried in bug reports after 2.6.20 got released, 
the minimum fix is to temporarily remove the WARN_ON().

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

