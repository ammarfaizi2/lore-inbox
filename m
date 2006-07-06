Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWGFX50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWGFX50 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWGFX50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:57:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:674 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751089AbWGFX5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:57:25 -0400
Date: Thu, 6 Jul 2006 16:53:37 -0700
From: Greg KH <greg@kroah.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       "Scott J. Harmon" <harmon@ksu.edu>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.17.4
Message-ID: <20060706235337.GA13418@kroah.com>
References: <20060706222704.GB2946@kroah.com> <20060706222841.GD2946@kroah.com> <44AD9229.6010301@ksu.edu> <20060706224614.GA3520@suse.de> <20060706234918.GB2037@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706234918.GB2037@1wt.eu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 01:49:18AM +0200, Willy Tarreau wrote:
> On Thu, Jul 06, 2006 at 03:46:14PM -0700, Greg KH wrote:
> > On Thu, Jul 06, 2006 at 05:43:53PM -0500, Scott J. Harmon wrote:
> > > Greg KH wrote:
> > > > diff --git a/Makefile b/Makefile
> > > > index 8c72521..abcf2d7 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1,7 +1,7 @@
> > > >  VERSION = 2
> > > >  PATCHLEVEL = 6
> > > >  SUBLEVEL = 17
> > > > -EXTRAVERSION = .3
> > > > +EXTRAVERSION = .4
> > > >  NAME=Crazed Snow-Weasel
> > > >  
> > > >  # *DOCUMENTATION*
> > > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > > index 0b6ec0e..59273f7 100644
> > > > --- a/kernel/sys.c
> > > > +++ b/kernel/sys.c
> > > > @@ -1991,7 +1991,7 @@ asmlinkage long sys_prctl(int option, un
> > > >  			error = current->mm->dumpable;
> > > >  			break;
> > > >  		case PR_SET_DUMPABLE:
> > > > -			if (arg2 < 0 || arg2 > 2) {
> > > > +			if (arg2 < 0 || arg2 > 1) {
> > > >  				error = -EINVAL;
> > > >  				break;
> > > >  			}
> > > Just curious as to why this isn't just
> > > ...
> > > 			if (arg2 != 1) {
> > > ...
> > 
> > Because that would be incorrect :)
> 
> Interestingly, 2.4 tests (arg2 !=0 && arg2 != 1) so from the code changes
> above, it looks like the value 2 was added on purpose, but for what ? Maybe
> the fix is not really correct yet ?

No, it's correct.  The change was incorrect.

thanks,

greg k-h
