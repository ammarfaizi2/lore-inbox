Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279303AbRJWHWX>; Tue, 23 Oct 2001 03:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279245AbRJWHWP>; Tue, 23 Oct 2001 03:22:15 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:6408 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S279303AbRJWHWG>; Tue, 23 Oct 2001 03:22:06 -0400
Message-ID: <3BD51A90.EC99E323@idb.hist.no>
Date: Tue, 23 Oct 2001 09:21:52 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: drevil@warpcore.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com> <20011022211622.B20411@virtucon.warpcore.org> <003801c15b7d$6e2e4410$01c510ac@c779218a> <20011023000826.A22123@virtucon.warpcore.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drevil@warpcore.org wrote:

> Secondly, I don't believe for a second that it isn't possible to trace things
> down even in a 'binary-only' driver. 

Sure it is possible, for someone with lots of time to waste.  And it
_is_ a
waste of time, because it can be traced down so much faster _with_ the
source.
But what would the point be?  Even if the kernel developers discover
a problem in the nvidia driver - what could they do?  Create a binary
patch?

> I trace things down in a 'binary-only'
> program every day practically when dealing with software, many times having the
> source to a program doesn't even help me. Often I find myself using strace or
> some other program to trace the execution flow of a program because it is often
> more informative then the poorly written source.
> 
> I'm not complaining about the NVidia driver here. I'm simply stating that IMHO,
> I find it odd that for years microsoft has not only retained binary
> compatability within a release of windows but API compatability. 

Lucky you.  I have seen third-party software break on the transition
from
windows95 to windows95 osr2 (or whatever they called that update)

> There should
> not be a change to the kernel that would require changes in the driver in a
> "stable development" release tree, it's really that simple in my perhaps
> somewhat limited view. Admittedly, this breakage (which is still in doubt) that
> might have happened did happen with a "pre" version, but I feel this response
> would have been no different even if that was not the case.
> 
It doesn't work that way.  There is no "stable api" guarantee.  People
try
for stable api's, but break them when doing so is useful.

> And as I've mentioned before, I know of specific cases (which I'm not allowed to
> divulge) where microsoft did not have access to the vendor's source to a
> specific driver, but they collected information that was then forwarded on to
> the vendor to handle the request. Nowhere during this entire 'discussion' did I
> see an offer to help the user possibly collect that information in a manner that
> would be helpful to the vendor, nor an offer of somewhat more information
> than "go cry to your vendor, you poor sap" effectively. That is what, if
> anything, I'm complaining about.

Nvidia has plenty of offers for help.  I am sure they will get it if
they
ask about "how should we adapt to this changed API".  No problem there. 
And
there is an even better offer:  GPL the driver, get it clean enough to
integrate it in the Linus tree, and this sort of thing won't happen!
Kernel internal API's change from time to time, but all affected drivers
in the Linus tree is usually fixed along with the change.  But they
won't take that offer, so they have to do the work themselves.

Note that a partial solution is possible too.  They could put their
secret
code in a binary module, and release source for a module that interface
to the secret one.  Then they'll have a perfectly stable interface
between the modules, and people can adapt the GPL interface module
to changing kernels.  They don't seem to do that either.

> I deal with issues often day during the course of developing software for my
> company that are often caused by other vendor's software, but does that mean I
> can tell all my customers "I'm sorry, a change I made or a bug in your vendor's
> software prevents this from functioning properly, and I can't help you at all."
> My customers wouldn't accept that answer for a minute, they demand something
> more than "sorry, it's not my fault." Often times we spend a good amount of time
> researching and finding a way to work around the issues with that vendor's
> product, which sometimes even involve "fixes" to our own product that exist for
> no other reason than because of that vendor's issues. And guess what, we still
> have customers :) And considering we're a somewhat small business in a dismal
> economy I attribute part of our success to that very thing...

Distributors can do what you want.  They may stick to an older kernel
until
nvidia fix their driver, or undo the particular patch that broke nvidia.
Many distributions have their own patch-sets for this sort of thing.

The responsibility for this falls on you the moment you go and grab
the kernel source though.  This is equivalent to getting the latest
daily build directly from the microsoft developers instead of buying 
the released upgrades.  

The difference is that youy actually _can_ get the latest linux build.
But you don't have to do that - you can stick to the larger distributors
who probably won't release a kernel without nvidia support.  They care
about customers, so stick to them if you consider yourself one.
The raw kernel source is for "interested people", not for "customers".

Helge Hafting
