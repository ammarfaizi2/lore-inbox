Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWIZWFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWIZWFE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 18:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWIZWFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 18:05:03 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:21676 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932434AbWIZWE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 18:04:59 -0400
Date: Wed, 27 Sep 2006 00:04:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: x86/x86-64 merge for 2.6.19
Message-ID: <20060926220457.GA12905@uranus.ravnborg.org>
References: <200609261244.43863.ak@suse.de> <200609262202.28846.ak@suse.de> <Pine.LNX.4.64.0609261318240.3952@g5.osdl.org> <200609262226.09418.ak@suse.de> <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609261339050.3952@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 01:44:42PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 26 Sep 2006, Andi Kleen wrote:
> > 
> > Yes that is why I did it. I still use quilt for my tree because it works
> > best for me, but together with all the i386 stuff I was over 230 patches
> > and email clearly didn't scale well to that much.
> 
> Right. I'm actually surprised not more peole use git that way. It was 
> literally one of the _design_goals_ of git to have people use quilt a a 
> more "willy-nilly" front-end process, with git giving the true distributed 
> nature that you can't get from that kind of softer patch-queue like 
> system.

One of the major benefits from git is that whenever I decide to
do some changes git allows me to start modifying as I like and when
done I just do "git diff | less" to review it. And when it turns out to be a piece of crap I just do "git reset --hard" and be done with it.
This make my life so much easier than having to copy symlinked tress
around all the time - and I then may not touch the base for the symlinks.

Put all other nice and usefull features aside this has been a major
timesaver for me both in the bk days and also now in the git days.
And quilt does not help me in this respect as I understood last I looked.

Using git sometimes does not work out that well for this.
But then I do a simple git format-patch HEAD~nn..HEAD which I apply on top
of a freshly cloned tree and we are back on track. This tricks works for me
since I have only two customers of my kbuild.git tree - akpm and Linus.
Where Linus just pulls into his tree so no problem, and Andrew seems to cope
fine with me doing a fresh tree now and then.

	Sam
