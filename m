Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271924AbRHVEFc>; Wed, 22 Aug 2001 00:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271923AbRHVEFW>; Wed, 22 Aug 2001 00:05:22 -0400
Received: from h00306536ddec.ne.mediaone.net ([66.31.18.88]:42611 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S271924AbRHVEFH>;
	Wed, 22 Aug 2001 00:05:07 -0400
To: bmihulka@hulkster.net
Cc: acpi@phobos.fachschaften.tu-muenchen.de, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] AGP support locks X - was Re: sony vaio, crude workar
In-Reply-To: <XFMail.20010818013001.bmihulka@hulkster.net>
From: Nick Papadonis <nick@coelacanth.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 22 Aug 2001 00:01:20 -0400
In-Reply-To: <XFMail.20010818013001.bmihulka@hulkster.net> (bmihulka@hulkster.net's message of "Sat, 18 Aug 2001 01:30:01 -0500 (CDT)")
Message-ID: <m3y9ocpwtr.fsf@coelacanth.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, my X server starts now. 

When I try to switch to a virtual text console, my screen blanks.  I
can still execute a shutdown command blindly.  This implies the kernel
hasn't locked up.

There must be some conflict with the VGA controller still?  Maybe the
work around to fix the dead console at boot?

- Nick


bmihulka@hulkster.net writes:
> I did experience this.  But when you choose AGP as a module it disables
> the drm of the i810.  I then added it back as a module and the X server would
> not work.  Without the i810 drm module it will work.  I did not test AGP in the
> kernel without the drm module, which may work.
> 
> On a side note the 2.4.5 kernels acpi implimentation will show the correct
> battery and ac adaptor status.  The stock kernels after that will not without
> the new acpi patches.  I have also had the problem of a shutdown will lock the
> system and I have to pull the plug and battery to turn off.

> On 18-Aug-2001 Nick Papadonis wrote:
> > This solved the problem.  Apparently AGP has to be built as a module
> > in kernels v2.4.8 or X will lock up?  Anyone else experience this?
> > 
> >> I'm not sure that this is the problem you are having,
> >> but I had a problem with X when I was playing with the
> >> ACPI stuff and recompiling the kernel on my vaio. Try 
> >> setting CONFIG_AGP=m (i.e. make AGP support a module,
> >> as opposed to being compiled in-kernel.) if it isn't. 
> >> Once I did that, X started up just fine. Good luck.
> >> 
> >> Dave
> > 
> > 
> > Dave Morgan <daves_spam_account@yahoo.com> writes:
> >> >> I tried this and it doesn't disable the console. 
> >> The /proc/acpi
> >> >> represents the correct power status.  When I tried
> >> to
> >> >> start up X the following error occurs:
> >> >> 
> >> >> I810 Dma Initialization Failed
> >> >> XIO:  fatal IO error 104 (Connection reset by peer)
> >> >on X server 
> >> >":0.0"
> >> >>       after 0 requests (0 known processed) with 0
> >> >events remaining.
> >> >> 
> >> >> So the work around must break something else?
> >> 
> >> >Follup:  
> >> 
> >> >This isn't because of the ACPI code.  It's something
> >> >that happens in
> >> >my 2.4.8 kernel wo ACPI compiled in.  This behavior
> >> is >not shown with
> >> >the 2.2.16 kernel.
> >> 
