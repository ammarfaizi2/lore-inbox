Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265515AbSKAAsj>; Thu, 31 Oct 2002 19:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265519AbSKAAsj>; Thu, 31 Oct 2002 19:48:39 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:48094 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265515AbSKAAsg>;
	Thu, 31 Oct 2002 19:48:36 -0500
Subject: Re: What's left over.
From: john stultz <johnstul@us.ibm.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031195442.Y1421@almesberger.net>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com>
	<Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com>
	<20021031031932.GQ15886@ns> <1036098562.12714.50.camel@cog>
	<20021031184933.B2599@almesberger.net> <1036103533.12714.71.camel@cog> 
	<20021031195442.Y1421@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 16:54:11 -0800
Message-Id: <1036112051.12713.134.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 14:54, Werner Almesberger wrote:
> john stultz wrote:
> > Ugh, that seems dangerous. Too many forgotten ACL links and then I could
> > accidentally give a vague acquaintance access to all my data meant for
> > close friends. 
> 
> The idea is that you'd typically have (a) (small number of) specific
> location(s) where you keep your files representing groups, e.g.
> $HOME/acls/ for your personal lists, maybe ~project/acls/ for
> projects, etc.

Oh! Ok, that's exactly like the user-definable ACL groups I was
describing. My mistake, I thought you were suggesting some crazy ACL
symlink like: "Make file foo's ACL be the same as file blah's ACL" and
if I then go and add some untrusted user to blah's ACL it would then
automatically change foo's ACL. That just seemed a bit out there, but it
was just my mis-interpretation. Sorry :)

> If you think already this is dangerous, then you should be
> terrified by regular, non-aggregateable ACLs ;-)

Eh, as long as the ACLs are per-file, I can't ever accidentally give
access to a file I didn't mean to. The corner cases of "remove my
ex-friend from all my files" could be annoying, but could be done w/ the
equiv of chgrp -r 

> I'm not saying that ACLs aren't useful, only that the lack of
> aggregateability makes them hard to maintain, so that people
> frequently fall back to setup scripts that simple re-create
> their ACL configuration. Once you're at this point, ACLs have
> lost much of their usefulness, and you might as well use some
> suid program that creates groups for you.

Hmmm. I'm way out of my realm of competency here. I just know ACLs were
*really* useful w/ AFS. 

I probably should just go read the specs. Anyone have a pointer, or care
to explain what the differences are between AFS's ACLs and POSIX ACLs?

thanks
-john




