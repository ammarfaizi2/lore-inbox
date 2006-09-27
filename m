Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWI0MdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWI0MdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWI0MdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:33:10 -0400
Received: from THUNK.ORG ([69.25.196.29]:7654 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932273AbWI0MdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:33:08 -0400
Date: Wed, 27 Sep 2006 08:32:47 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060927123247.GA14668@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Sergey Panov <sipan@sipan.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <1159319508.16507.15.camel@sipan.sipan.org> <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 07:55:41AM +0200, Jan Engelhardt wrote:
> If by operating system you mean the surrounding userland application, 
> then yes, why should there be a problem with a GPL2 kernel and a GPL3 
> userland? After all, the userland is not only GPL, but also BSD and 
> other stuff.

Actually, the biggest problem will likely be userland applications and
shared libraries.  Many people believe that the GPL infects across
shared library links.  Whether or not that's true, it's never been
tested in court, and probably depends on the legal jurisdiction.  In
any case, many parts of the community, and certainly distributions
like Debian, behave as if the GPL infects across shared libraries.
But if that's true, then we have a big problem, because just as the
CDDL is incompatible with GPLv2, so too is the GPLv3 incompatible with
GPLv2.  (It has to be; the whole point of the GPLv3 is to fix "bugs"
such as spiking out companies considered evil like Tivo.  If you're
going to make the argument that there are no differences and so the
GPLv2 and v3 are compatible, then why are we wasting all of this time
and money on GPLv3?)

And if there are additional restrictoins in GPLv3 (and I've never
heard Eben deny it), then there's nothing you can do in GPLv3 to fix
the compatibility problem, because GPLv3 has more restrictions than
GPLv2, and the GPLv2 prohibits additional restrictions.  So the
incompatibility is forced from the GPLv2 side, and no textual changes
in GPLv3 can possibly hope to fix things.  Hence, for userspace code
which is licensed under a GPLv2 only license, it must be strictly
incompatible with any GPLv3 shared library.

And given that Stallman has announced that the new LGPL will be (to
use programming terms) a subclass of GPLv3, it means that the LGPLv3
is by extension incompatible with the GPLv2.  So that means that there
will have to be two different versions of glibc (and every other
shared library) shipped with every distributions --- one which is
GPLv2, and one which is GPLv3.  And this fork is going to be forced by
the FSF!  

So that brings up an interesting question --- which fork is Uhlrich
Drepper going to continue to work on?  The GPLv2 or GPLv3 version?  :-)

						- Ted

P.S.  I guess there is another alternative, which is that all shared
libraries must be dual licensed under a "your choice of LGPLv2 or
LGPLv3".  Of course, then that won't prohibit CCE's (Companies
Considered as Evil) from using said code.  And certainly, for people
who care more about code reuse, I would urge them to dual license
their code, since otherwise GPLv2 and GPLv3 code will not be able to
coexist, and the FSF will be making the license fragmentation problem
even worse for everyone, just to pursue their political goals.
