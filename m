Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUBWUjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUBWUia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:38:30 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:2691 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262040AbUBWUc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:32:59 -0500
Date: Mon, 23 Feb 2004 21:32:57 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jim Wilson <wilson@specifixinc.com>
Cc: linux-kernel@vger.kernel.org, Judith Lebzelter <judith@osdl.org>,
       Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
       "Timothy D. Witham" <wookie@osdl.org>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040223203257.GA9800@MAIL.13thfloor.at>
Mail-Followup-To: Jim Wilson <wilson@specifixinc.com>,
	linux-kernel@vger.kernel.org, Judith Lebzelter <judith@osdl.org>,
	Dan Kegel <dank@kegel.com>, cliff white <cliffw@osdl.org>,
	"Timothy D. Witham" <wookie@osdl.org>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <1077565352.1054.22.camel@leaf.tuliptree.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077565352.1054.22.camel@leaf.tuliptree.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 11:42:31AM -0800, Jim Wilson wrote:
> On Sat, 2004-02-21 at 19:53, Herbert Poetzl wrote:
> > Here is an update to the Kernel Cross Compiling thread 
> > I started ten days ago ...
> 
> If you want gcc to be fixed so the inhibit_libc builds work for linux
> targets, then I suggest opening an FSF gcc bugzilla bug report.  Sending
> mail to me or to the linux kernel mailing list is unlikely to accomplish
> this.

hmm, sorry, I didn't want to tantalize you with mails,
I just thought you would be interested in them ...

my apologies here, will avoid further mails to your account

my primary goal isn't to get this fixed by the gcc folks,
I want to have a simple and working solution, which seems
to be at hand for the toolchains, to cross compile the
linux kernel for testing purposes. the changes so far are
not very intrusive IMHO, and I can live with a few patches.
(btw. currently Dan Kegel has a lot more patches to gcc in 
his toolchain than I do)

> FYI David Mosberger sent me a comment in private mail pointing out that
> if you are trying to bootstrap linux on a new target, then requiring a
> glibc port before the kernel port is a problem.  I consider this a good
> reason to make this feature work.

sounds reasonable ... at least to me ;)

> However, my recommendation still stands.  In general, I do not recommend
> building inhibit_libc crosses for linux targets, even though such
> crosses are likely to work fine for building a kernel.  As a gcc
> maintainer, it makes my job harder when people are building the compiler
> different ways, because I may get bug reports that I can't reproduce or
> understand.  Also, there is a risk that a kernel-only cross compiler
> will accidentally be used for some other purpose, resulting in a bug
> report that wastes the time of the gcc maintainers.

originally I had the weird? opinion, that gcc (or it's
build system) does support the cross target to exactly
do this (building an initial gcc, which can be used to
compile other stuff, like (g)libc and such) ...

that this looks like some kind of hack is neither my fault
nor does it justify messing around with 'unbuildable'
(g)libcs to get a kernel cross compile working ...

best,
Herbert

> -- 
> Jim Wilson, GNU Tools Support, http://www.SpecifixInc.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
