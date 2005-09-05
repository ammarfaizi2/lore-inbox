Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVIEGEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVIEGEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVIEGEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:04:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:30226 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932228AbVIEGEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:04:15 -0400
Date: Mon, 5 Sep 2005 08:04:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Sean <seanlkml@sympatico.ca>
Cc: Willy Tarreau <willy@w.ods.org>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050905060405.GA16784@alpha.home.local>
References: <35547.10.10.10.10.1125892279.squirrel@linux1> <20050905040311.29623.qmail@web50204.mail.yahoo.com> <50570.10.10.10.10.1125893576.squirrel@linux1> <20050905043613.GD30279@alpha.home.local> <46230.10.10.10.10.1125895623.squirrel@linux1> <20050905050108.GA16596@alpha.home.local> <59215.10.10.10.10.1125898289.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59215.10.10.10.10.1125898289.squirrel@linux1>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 01:31:29AM -0400, Sean wrote:
> On Mon, September 5, 2005 1:01 am, Willy Tarreau said:
> 
> > But how do you think Linux has penetrated the enterprise market ???
> > We all have put dual boots on every windows machine we had access to,
> > eventhough this was clearly forbidden. And after repeatedly showing
> > to the staff that you saved their day with your Linux, they finally
> > start to get interested to it. One of my best customers has finally
> > bought about one hundred RHEL3 licences to replace amateur installs
> > on production machines. They would never have looked at it without
> > us braving unauthorized dual boots.
> 
> And how impressed would they have been if you had to install a bunch of
> binary drivers to get the job done?   Do you think all the problems that
> are associated with binary drivers would not have bitten you or your
> company?

They don't mind. Those people install Checkpoint on Linux. A product of
which previous releases were even incompatible with security updates !

> What you're talking about did happen, but it didn't happen on laptops, and
> it didn't happen with binary drivers.   It happened naturally when Linux
> grew mature enough to support servers without the need for binary-only
> hacks.

You don't get it. One of my collegue installed quagga on his binary-only
laptop. Now that he found it very useful and showed how to can be used,
he's planning on setting up servers to run it to bring new services. So
his *crappy* laptop full of binary-only drivers and relying on ndiswrapper
allows him to build a proof of concept and get the possibility to run it
on real hardware.

> Trying to accelerate the acceptance of Linux on the desktop with binary
> hacks is simply counterproductive.
> 
> > I think we should not worry about it, but we should not deliberately break
> > it in a stable series when that does not bring anything. The fact that
> > Adrian proposed to completely remove the option is sad. It's in the
> > windows
> > world that you can't choose. In Linux, you make menuconfig and choose what
> > suits your needs.
> 
> That's the beauty of open source; nobody is being deprived of a choice. 
> Anyone can simply patch their kernel with 8K support if that's what they
> need.   But as has been aptly pointed out by others in this thread, 8K
> stacks aren't really needed at all, even for NDISwrapper.

Except that someone has to maintain the patch, because with the speed the
kernel is changing, a patch against 2.6.14 will not work on 2.6.15. I've
tried UML on 2.4 in the past, and I've learned the hard way not to rely
on patches for old features when developpers consider them obsolete (2.4
support ended when 2.6 began).

> 4K stacks were NOT invented to hassle binary-only driver owners, they were
> created to solve problems associated with 8K stacks..  Leaving the 8K
> stack option in the kernel signals that it is a _good_ option.  That just
> isn't true, so the option should be removed or at least marked BROKEN.

Keeping it marked as BROKEN is fine. It may even taint the kernel, that's
not a problem. Removing it is wrong.

Regards,
Willy

