Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWBCJTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWBCJTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWBCJTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:19:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:8856 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932153AbWBCJTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:19:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
Date: Fri, 3 Feb 2006 10:18:34 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, nigel@suspend2.net,
       suspend2-devel@lists.suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060202171812.49b86721.akpm@osdl.org> <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
In-Reply-To: <20060203124253.m6azcn4wg88gsogc@imp.rexursive.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602031018.35669.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 03 February 2006 02:42, Bojan Smojver wrote:
> Quoting Andrew Morton <akpm@osdl.org>:
> 
> > This leaves us in rather awkward position.  You see, there will be other
> > people whose machines don't work with suspend2 but which do work with
> > swsusp.  And other people who prefer swsusp for other reasons.
> 
>  From what I can see on suspend2 development list, Nigel regularly 
> addresses people's problems with his code, which then results in 
> working systems. Most times when people see problems with suspend2, it 
> is the drivers that can't do suspend that are the root cause (at least 
> that seems to be the pattern on the suspend2 mailing list).
> 
> The only way for a much broader community to experience and test 
> suspend2 is to put it in the mainline kernel. I'm not sure why that is 
> such a problem...
> 
> > It'd help if we knew _why_ your machine doesn't work with swsusp so we can
> > fix it.  Futhermore it'd help if we knew specifically what you prefer about
> > suspend2 so we can understand what more needs to be done, and how we should
> > do it.
> 
> Here is what I prefer in suspend2:
> 
> - it works (i.e. I have compiled it for at least 20 different Rawhide 
> kernels and it always suspended/resumed properly)
> 
> - it is reliable (e.g. I have suspended/resumed mid kernel compile  - 
> actually, kernel RPM build, which included compile - many times, 
> without any ill effect)
> 
> - it is fast (i.e. even on my crappy old HP ZE4201 
> [http://www.rexursive.com/articles/linuxonhpze4201.html], it writes all 
> of 700+ MB of RAM to disk just as fast or faster than swsusp).
> 
> - it looks nice (both text and GUI interface supported)
> 
> - it leaves the system responsive on resume (kinda nice to come back to 
> X and "Just Use it")
> 
> - it suspends to both swap and file (I personally use swap, but many 
> people on the list use file)
> 
> Just today, I tried the most recent Rawhide kernel (based on 
> 2.6.16-rc1-git5) with swsusp and for the first time *ever* it actually 
> returned X to its original state (I was so excited, I even notified 
> people on suspend2 development list about it). But, on second 
> suspend/resume, it promptly locked up my system.

Well, it would help if you said in which stage of suspend/resume
it actually locked up the system.

Anyway, we are working on fixing these problems right now,
so maybe you'd like to test some patches?

> Before, it would simply lock up. So, if swsusp can be made to actually work,
> be reliable, look nice and be responsive on resume, I'm all for it.

I think it can be, hopefully with Nigel's help.

> I will  miss Nigel's excellent support though, but I'm sure he deserves a break 
> :-)

I'm definitely interested in resolving your problems with swsusp, so could
you please send me a boot log from your box?  Also, if you are able to
get a serial console or net console output from it during suspend/resume,
especially in the failing case, that would help a lot. [Please do not litter
the list with that, though.]

Greetings,
Rafael
