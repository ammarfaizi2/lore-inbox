Return-Path: <linux-kernel-owner+w=401wt.eu-S1751786AbWLQUty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWLQUty (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 15:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWLQUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 15:49:53 -0500
Received: from mtl.rackplans.net ([69.90.0.18]:37236 "EHLO mtl.rackplans.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbWLQUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 15:49:52 -0500
X-Greylist: delayed 1603 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 15:49:52 EST
Date: Sun, 17 Dec 2006 15:23:07 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
X-X-Sender: gmack@mtl.rackplans.net
To: Dave Jones <davej@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <w@1wt.eu>,
       karderio <karderio@gmail.com>, linux-kernel@vger.kernel.org,
       support@ati.com
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
In-Reply-To: <20061216183301.GA14286@redhat.com>
Message-ID: <Pine.LNX.4.64.0612171515420.24115@mtl.rackplans.net>
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org>
 <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org>
 <20061216064344.GF24090@1wt.eu> <Pine.LNX.4.64.0612160820240.3557@woody.osdl.org>
 <20061216164947.GB31013@1wt.eu> <Pine.LNX.4.64.0612160858100.3557@woody.osdl.org>
 <20061216183301.GA14286@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006, Dave Jones wrote:

> On Sat, Dec 16, 2006 at 09:20:15AM -0800, Linus Torvalds wrote:
> 
>  > Anything else, you have to make some really scary decisions. Can a judge 
>  > decide that a binary module is a derived work even though you didn't 
>  > actually use any code? The real answer is: HELL YES. It's _entirely_ 
>  > possible that a judge would find NVidia and ATI in violation of the GPLv2 
>  > with their modules.
> 
> ATI in particular, I'm amazed their lawyers OK'd stuff like..
> 
> +ifdef STANDALONE
>  MODULE_LICENSE(GPL);
> +endif
> 
> This a paraphrased diff, it's been a while since I've seen it.
> It's GPL if you build their bundled copy of the AGPGART code as agpgart.ko,
> but the usual use case is that it's built-in to fglrx.ko, which sounds
> incredibly dubious.
> 
> Now, AGPGART has a murky past wrt licenses.  It initally was imported
> into the tree with the license "GPL plus additional rights".
> Nowhere was it actually documented what those rights were, but I'm
> fairly certain it wasn't to enable nonsense like the above.
> As it came from the XFree86 folks, it's more likely they really meant
> "Dual GPL/MIT" or similar.
> 
> When I took over, any new code I wrote I explicitly set out to mark as GPL
> code, as my modifications weren't being contributed back to X, they were
> going back to the Linux kernel.  ATI took those AGPv3 modifications from
> a 2.5 kernel, backported them to their 2.4 driver, and when time came
> to do a 2.6 driver, instead of doing the sensible thing and dropping
> them in favour of using the kernel AGP driver, they chose to forward
> port their unholy abomination to 2.6.
> It misses so many fixes (and introduces a number of other problems)
> that its just unfunny.
> 
> The thing that really ticks me off though is the free support ATI seem
> to think they're entitled to.  I've had end-users emailing me
> "I asked ATI about this crash I've been seeing with fglrx, and they
>  asked me to mail you".
> 
> I invest my time into improving free drivers.  When companies start
> expecting me to debug their part binary garbage mixed with license
> violations, frankly, I think they're taking the piss.
> 
> A year and a half ago, I met an ATI engineer at OLS, who told me they
> were going to 'resolve this'.  I'm still waiting.
> I live in hope that the AMD buyout will breathe some sanity into ATI.
> Then again, I've only a limited supply of optimism.

You would think ATI's steaming pile of crap would be a good reason for 
them to give up on the whole binary module thing and just release specs so 
someone else can write a decent driver.

I made the mistake of purchasing an ATI X1600.  No open kernel driver.. no 
open X driver.  The ATI drivers don't even complile on amd64 on any 
recent kernel and their X drivers are prone to random screen corruption 
that requires nothing less than a full reboot to clear.

IMO let those morons keep writing themselves into a corner with this crud 
and then perhapse they will see for themselves that binary modules are a 
horribly bad idea instead of having someone else to blame when this whole 
thing finally fails.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
