Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288671AbSA2GHp>; Tue, 29 Jan 2002 01:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288664AbSA2GHf>; Tue, 29 Jan 2002 01:07:35 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:36080 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S288662AbSA2GHZ>; Tue, 29 Jan 2002 01:07:25 -0500
Date: Tue, 29 Jan 2002 00:51:55 -0500
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129005155.A6726@pimlott.ne.mediaone.net>
Mail-Followup-To: Rob Landley <landley@trommello.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, you make a nice case, but consider a few points.

One,

> This integration and patch tracking work is a fairly boring, thankless task, 
> but it's work somebody other than Linus can do, which Linus has to do 
> otherwise. (And which Linus is NOT doing a good job at right now.)

... are you _sure_ that Linus does this?  My sense is that he mostly
eschews integration grunt-work.  If that is so, it's possible that
Linus is already operating near top efficiency, and that his
throughput is as high as he wants it to be!  Linus has pointed out
more than once that a big part of his job is to limit change.  Maybe
he's happy with the current rate of change in 2.5.  (That doesn't
mean everything is optimal--he might wish for higher quality changes
or a different mix of changes, just not more.)

Two, Linus has argued that maintainers are his patch penguins;
whereas you favor a single integration point between the maintainers
and Linus.  This has advantages and disadvantages, but on the whole,
I think it is better if Linus works directly with subsystem
maintainers.  To the extent that Linux is modular, there is little
need for the extra layer (so it is just overhead).  And when there
is a real conflict between subsystems--that's probably just the time
when Linus and the maintainers need to be collaborating directly!
The only "but" is that many people find it hard to work with Linus.
However, Linus made clear in his message that he considers this a
solvable problem (and maybe one you should work on!).

> Finished code 
> regularly goes unintegrated for months at a time, being repeatedly resynced 
> and re-diffed against new trees until the code's maintainer gets sick of it. 

Assuming that your system doesn't dramatically increase Linus's
throughput, code will still have to be re-diffed.  I don't agree
that thrusting all the merging onto one person is the right
solution.  That person is a _much_ bigger scalability bottleneck
than Linus, because (by your definition of the role) he can't drop
patches!  So he will inevitably become overwhelmed, and then we have
a bigger mess.

Frankly, if I were a maintainer, I would want the patch that finally
gets integrated to be one that I produce, not one re-diffed by
someone less familiar with the subsystem.  So, I side with Linus's
"tough, that's part of the maintainer's job" stance.  (Now, tools to
help resync, and to eliminate the tedium of re-submitting to Linus
periodically, would be welcome.)

> Several of the bug fixes in Alan's tree (which he 
> stopped maintaining months ago) still are not present in 2.4.17 or 2.5.

This is plain evidence that a single integration point (and there is
no better than Alan) isn't a panacea.

Three, regarding your complaint about "clean-up" patches being
dropped: maybe this just means there is a maintainer missing from
the pantheon: the clean-up maintainer.

Andrew

