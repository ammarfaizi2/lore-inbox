Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVIQQfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVIQQfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 12:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVIQQfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 12:35:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63361 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751141AbVIQQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 12:35:03 -0400
Date: Sat, 17 Sep 2005 11:34:34 -0500
From: Jack Steiner <steiner@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: Tony Luck <tony.luck@gmail.com>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: 2.6.14-rc1 breaks tg3 on ia64
Message-ID: <20050917163434.GB24322@sgi.com>
References: <20050913065937.GA7849@kroah.com> <25288.1126596450@kao2.melbourne.sgi.com> <12c511ca05091708476aa136cd@mail.gmail.com> <20050917155911.GB19854@tuxdriver.com> <20050917161617.GA23171@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917161617.GA23171@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2005 at 09:16:17AM -0700, Greg KH wrote:
> On Sat, Sep 17, 2005 at 11:59:14AM -0400, John W. Linville wrote:
> > On Sat, Sep 17, 2005 at 08:47:03AM -0700, Tony Luck wrote:
> > > > >So does reverting this patch solve the problem?
> > > > 
> > > > I reversing
> > > > http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=064b53dbcc977dbf2753a67c2b8fc1c061d74f21,
> > > > which appears to be the latest version of this patch.  There was a
> > > > patch reject in sparc64, but the common code was reverted.  IA64 (SGI
> > > > Altix) with that patch reverted now boots 2.6.14-rc1.
> > > 
> > > Anyone know anything more about this problem?  I'm not seeing it
> > > on any of my systems ... so perhaps it only affects cards with a
> > > PCI bridge on them, or cards that haven't already been initialized
> > > by EFI.
> > 
> > I posted a patch on Wednesday:
> > 
> > 	http://www.ussg.iu.edu/hypermail/linux/kernel/0509.1/2193.html
> > 
> > The original reporter (Keith Owens <kaos@sgi.com>) confirmed this
> > patch to fix the problem.
> 
> Yes, and a number of people objected to that patch.  Care to respond to
> them?

We are working on an SN-only workaround. No guarantee, but the person
working on it is optimistic that we can fix the problem in SN code
w/o making any generic changes. I should know more on Monday.

Long term, we are making SN ACPI compliant - or at leeast a lot closer.


> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


