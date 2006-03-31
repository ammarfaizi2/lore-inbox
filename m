Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWCaX4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWCaX4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWCaX4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:56:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49423 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751278AbWCaX4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:56:17 -0500
Date: Sat, 1 Apr 2006 01:56:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: smp_locks reference_discarded errors
Message-ID: <20060331235615.GA28310@stusta.de>
References: <20060325033948.GA15564@redhat.com> <20060325235035.5fcb902f.akpm@osdl.org> <20060326154042.GB13684@redhat.com> <20060326161055.GA4584@mars.ravnborg.org> <20060331190851.GB22677@stusta.de> <20060331193338.GA10664@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331193338.GA10664@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 09:33:38PM +0200, Sam Ravnborg wrote:
> On Fri, Mar 31, 2006 at 09:08:51PM +0200, Adrian Bunk wrote:
> > On Sun, Mar 26, 2006 at 06:10:55PM +0200, Sam Ravnborg wrote:
> > > On Sun, Mar 26, 2006 at 10:40:42AM -0500, Dave Jones wrote:
> > > > 
> > > > came out of a 'make buildcheck' a day or two ago (the following day,
> > > > Sam nuked reference_discarded.pl in favour of it being done
> > > > magically somewhere else (I've not looked into how its done now).
> > > The check is part of modpost now. modpost is only used when building
> > > modules but that holds true for most builds anyway therefore I did not
> > > move it to a separate executable.
> > >...
> > 
> > This doesn't sound good.
> > 
> > This means that we have no longer any tool that warns us about e.g. 
> > references from non-__exit code to __exit code [1]?
> > [1] __exit, not __{dev,cpu,mem}exit
> 
> It does warn for this also. The test I have carried out has mostly been
> on allmodconfig builds though. I assume you are worried for the case
> when a module is built-in and the __exit section is discarded - or?

Exactly - especially since in kernel 2.6 we are getting on architectures 
like i386 no longer link errors as we did in kernel 2.4.

Perhaps I'm only concerned because my usual builds didn't produce a 
single warning...  ;-)

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

