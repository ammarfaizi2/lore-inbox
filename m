Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUBVVZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 16:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUBVVZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 16:25:33 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:63757 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261689AbUBVVZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 16:25:32 -0500
Date: Sun, 22 Feb 2004 16:25:28 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0402221227200.374124-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0402221620090.20455-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Feb 2004, Ron Peterson wrote:
> On Sat, 21 Feb 2004, Ron Peterson wrote:
> > On Fri, 20 Feb 2004, Andrew Morton wrote:
> > 
> > > There are a few things you should try - you probably already have:
> > > 
> > > - Stop all applications, restart them
> > > 
> > > - Unload net driver module, reload and reconfigure it.
> > > 
> > > If either of those (or similar operations) are found to bring the latency
> > > back to normal then that would be a big hint.  ie: we need to find
> > > something which brings the performance back apart from a complete reboot.
> 
> This machine is starting to head south again.  I've updated user.log (a
> bunch of stats I'm syslogging) at
> http://depot.mtholyoke.edu:8080/tmp/.  I've also added
> http://depot.mtholyoke.edu:8080/tmp/mist/10/, which contains the latest 
> smokeping graphs.
> 
> In about an hour or two, I'll likely have to head in to get this thing
> back on its feet.  I will try the suggestions above, to see if that will
> do the trick.  Is there anything else I should try to do or look at?  Once
> I reboot (if that's what I have to do), I expect it will be a couple of
> days before this happens again.

I couldn't get it back.  I stopped apache, mimedefang, sendmail,
imapproxyd, and ifdown'd the interfaces.  Waited a bit, put them back up,
and still had large ping times.  I then ifdown'd the interface and removed
the e1000 module.  I couldn't get it back again though, I think because I
had some nfs mounts I couldn't unmount.

I rebooted.  I set the BIOS to not run hyperthreaded, to see if that has
any effect.  Now wait...

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

