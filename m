Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263418AbVCDXm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbVCDXm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263214AbVCDXhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:37:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:61121 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S263224AbVCDV2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:28:10 -0500
Date: Fri, 04 Mar 2005 16:27:11 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: RFD: Kernel release numbering
In-reply-to: <Pine.LNX.4.58.0503041223210.11349@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.62.0503041534020.15953@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random>
 <20050303160330.5db86db7.akpm@osdl.org>
 <20050304025746.GD26085@tolot.miese-zwerge.org>
 <20050303213005.59a30ae6.akpm@osdl.org>
 <1109924470.4032.105.camel@tglx.tec.linutronix.de>
 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
 <20050304012154.619948d7.akpm@osdl.org>
 <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
 <Pine.LNX.4.62.0503041352480.15953@localhost.localdomain>
 <Pine.LNX.4.58.0503041223210.11349@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005, Linus Torvalds wrote:

> 
> 
> On Fri, 4 Mar 2005, Nicolas Pitre wrote:
> > 
> > It might still be worth a try, especially since so many people are 
> > convinced this is the way to go (your fault or not is not the point).
> 
> Making releases is actually a fair bit of work. Not the script itself, but 
> just deciding and trying to synchronize. The fatc that people won't really 
> appreciate it anyway, and just complain about "that's not stable anyway" 
> just makes me even less interested.

Don't read me wrong.

It's not the work that is being done which is the problem.  To the 
contrary, the current process is really great and for one I hope 2.7.x 
will _never_ happen, and here's why:

Coming from the embedded world I can tell you that 2.5.x was simply too 
"instable" to use as a basis for a product, and communities around non 
i386 architectures simply don't have enough man power to follow two 
kernel trees (2.4.x and 2.5.x) in parallel.  The embedded world 
therefore ended up developing on 2.4.x only because that was the stable 
tree that could bring revenues to sustain said development, even if 2.4.x 
was a dead end.

Now the catch up phase on 2.6.x within the embedded world is almost done 
and 2.6.x is also where the major developments are happening.  It's 
therefore way easier for smaller communities to stay in the game since 
2.6.x is also stable enough for commercial products despite the rapid 
development actually occurring there.  There are certainly a few more 
stability glitches than you could have found in 2.4.x but overall 2.6.x 
is a much better compromise bringing much more value to us -- thanks to 
your hard work and Andrew's (and RMK's) and everybody else for making 
the current process so efficient and dynamic.

Now back to the current discussion.  What people are complaining about 
is the lack of testing on the official 2.6.x releases.  This lack of 
testing comes from the fact that your -rc releases are not seen like 
stable enough for the mass to test, and this is due mainly because the 
people outside of the development loop have no idea when you actually 
called for a patch calm down.

It's not like you don't actually call for a calm down in order to have a 
release stabilized because, as Andrew pointed out, you effectively only 
merged true bug fixes into 2.6.11-rc[45].  See? You _do_ it and you 
_did_ it already.

The only issue is to actually have way more people to jump in and try 
out kernels which are in that "calm down" phase.  And for that to happen 
you need a clear signal to the people outside the development loop who 
currently can't trust your -rc releases since they end up including more 
than just bug fixes up to a randomly chosen particular -rc.

That's why many are suggesting that you consider switching to -pre 
releases for developer sync points, and for the last -pre release where 
you call for a calm down.  Then subsequent releases are -rc releases 
with strictly bug fixes.  For example, 2.6.11-rc[123] would have been 
2.6.11-pre[123] and 2.6.11-rc[45] would have been 2.6.11-rc[12].

See how this won't change anything to your work methodology besides the 
naming?  And this has the potential of bringing more testers not closely 
following lkml or the commit log (granted that -rc becomes real 
release-candidate-bug_fix_only releases but again you do that already) 
since they'll see those -rc releases as nearly official releases.  Of 
course it might not bring the hoped result but it costs nothing to try 
it out.  That's what I meant in my previous email.

P.S.: this is not incompatible with the "sucker" tree -- in fact both 
of those things might be useful and effective for their own purpose.


Nicolas
