Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbREUPoL>; Mon, 21 May 2001 11:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261444AbREUPoB>; Mon, 21 May 2001 11:44:01 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:55564
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S261433AbREUPny>; Mon, 21 May 2001 11:43:54 -0400
Date: Mon, 21 May 2001 08:36:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jes Sorensen <jes@sunsite.dk>
Cc: Jakob ?stergaard <jakob@unthought.net>, "Robert M. Love" <rml@tech9.net>,
        John Cowan <jcowan@reutershealth.com>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010521083602.C9965@opus.bloom.county>
In-Reply-To: <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com> <d31ypj1r4y.fsf@lxplus015.cern.ch> <990411054.773.0.camel@phantasy> <20010521043553.C20911@unthought.net> <d3ofsnowfp.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <d3ofsnowfp.fsf@lxplus015.cern.ch>; from jes@sunsite.dk on Mon, May 21, 2001 at 11:58:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 11:58:34AM +0200, Jes Sorensen wrote:
> >>>>> "Jakob" == Jakob ?stergaard <jakob@unthought.net> writes:
> 
> Jakob> On Sun, May 20, 2001 at 10:10:49PM -0400, Robert M. Love wrote:
> >> I think this is a very important point, and one I agree with.  I
> >> tend to let my distribution handle stuff like python.  now, I use
> >> RedHat's on-going devel, RawHide. it is not using python2.  in
> >> fact, since switching to python2 may break old stuff, I don't
> >> expect python2 until 8.0. that wont be for 9 months.  90% of
> >> RedHat's configuration tools, et al, are written in python1 and
> >> they just are not going to change on someone's whim.
> 
> Jakob> 2.6.0 isn't going to happen for at least a year or two.  What's
> Jakob> the problem ?
> 
> Jakob> Want 2.5.X ?  Get the tools too.
> 
> Some people grab the latest devel kernels because thats all that works
> on their hardware.

And they can grab the latest tools too.  Why is this a problem again?
python1.5.x is compatiable w/ python2 EXCEPT in the cases where the script
uses undocumented things which did work in python1.5.x.  But that's not as
big of a problem since they can co-exist.  Debian already does this (And thus
CML2 already deals with python2 being called 'python2') and I wouldn't be
supprised if the PowerTools python2 rpm someone pointed out makes them
co-exist as well.

Which brings up another point, RedHat (7.1?) and Debian/woody both have the
option of having python2 around.  Anyone know about mandrake?  My point is
that some dists are already dealing with python2.

> Jakob> I'm in no position to push people around, but I think the
> Jakob> whining about CML2 tool requirements is completely unjustified.
> Jakob> If we required that everything worked with GCC 2.7.2 and nmake,
> Jakob> where would we be today ?  I'm a lot more worried about CML2
> Jakob> itself than about the tools it requires :)
> 
> gcc-2.7.2 is broken it miscompiles the kernel, Python1 or bash are
> not.

Well no, but python1 requires another 2k lines of python code or so.
Eric, would it be easy/possible to go back to requiring python 1.5.x for
CML2, since that is what many dists ship with?

> Jakob> Whether CML2 requires python2 or not, the distributions will
> Jakob> change. This is not about Eric pushing something down people's
> Jakob> throats. Tools evolve, and new revisions introduce
> Jakob> incompatibilities, but distributions still follow the
> Jakob> evolution.  Nobody ships perl4 today either.
> 
> The point is that Eric has been trying to push distributions to ship
> P2.

Maybe, maybe not.  Forgetting about the QA time and whatnot, there's good
odds that all of the python scripts RedHat (for example) ships will just
work with python2.  I know one of the PPC dists didn't ship with python2
(which does have a lot of python bits to it) entirely because they were
already in testing when it came out.  It's not something the distros
can switch to at a whim, but it's also something which shouldn't cause
them problems when they do.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
