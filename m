Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265257AbSJaRI3>; Thu, 31 Oct 2002 12:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265258AbSJaRI3>; Thu, 31 Oct 2002 12:08:29 -0500
Received: from herald.cc.purdue.edu ([128.210.11.29]:18850 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id <S265257AbSJaRI1>; Thu, 31 Oct 2002 12:08:27 -0500
Date: Thu, 31 Oct 2002 12:13:34 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021031171334.GA22597@snerble.cc.purdue.edu>
Reply-To: shuey@purdue.edu
References: <Pine.LNX.4.44.0210302224180.20210-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
From: Michael Shuey <shuey@purdue.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a user, and I request that LKCD get merged into the kernel. :-)

On Thu, Oct 31, 2002 at 07:46:08AM -0800, Linus Torvalds wrote:
> What I'm saying by "vendor driven" is that it has no relevance for the 
> standard kernel, and since it has no relevance to that, then I have no 
> incentives to merge it. The crash dump is only useful with people who 
> actively look at the dumps, and I don't know _anybody_ outside of the 
> specialized vendors you mention who actually do that.

I actively look at LKCD dumps.  I have no affiliation with SGI, IBM, or any
of the previously mentioned companies.  I'm not aware of any vendors providing
pre-patched kernels with LKCD; right now my only option for reasonable crash
data is to patch and build my own kernel.

> I will merge it when there are real users who want it - usually as a
> result of having gotten used to it through a vendor who supports it. (And
> by "support" I do not mean "maintain the patches", but "actively uses it"
> to work out the users problems or whatever).

Here at Purdue University we're building several Linux clusters.  LKCD is
most useful to help find in-kernel problems.  Most of the time our crashes
are due to a flakey stick of RAM or a dying disk (or controller), but LKCD
dumps are still useful.  With a crash dump I can analyze the cause of the
crash after the fact, but without a dump my only option to get _any_ crash
data is to leave a console plugged into each node of my clusters.

Do you feel like donating a 700-port console server?  Right, so it's LKCD
for me then.

> People have to realize that my kernel is not for random new features. The
> stuff I consider important are things that people use on their own, or
> stuff that is the base for other work. Quite often I want vendors to merge
> patches _they_ care about long long before I will merge them (examples of
> this are quite common, things like reiserfs and ext3 etc).
> 
> THAT is what I mean by vendor-driven. If vendors decide they really want
> the patches, and I actually start seeing noises on linux-kernel or getting
> requests for it being merged from _users_ rather than developers, then
> that means that the vendor is on to something.

I understand that Linux can't have random new features (especially going into
a feature-freeze).  However, any additions that provide better debugging info
are (in my opinion, at any rate) worth it.  Every other UNIX I've used (with
the possible exception of an early Ultrix) has some facility to inspect the
kernel - all have _at_least_ dumps that get written to a swap disk on a crash
and many have an in-core debugger.  Running gdb on a live kernel from a
remote machine isn't unheard of, at least with other OSes.  Unfortunately,
only aid you'll get in debugging a Linux kernel is the source code.  Sure,
you can add a mess of printk's all over suspect code, and yes, the console
gets a register dump on a panic, but that really isn't enough.  Some times
it's nice to be able to walk through the kernel's data structures and figure
out just what was going on when things died.  I get this with LKCD.

To that end, it'd be nice if the trace toolkit and SGI's kernel debugger were
added.  No, I haven't used them, but then I don't do much kernel development
either.  I'd bet that LTT and the kernel debugger would be very useful to
those who do, though.

-- 
Mike Shuey
