Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265557AbSKAB0g>; Thu, 31 Oct 2002 20:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265559AbSKAB0K>; Thu, 31 Oct 2002 20:26:10 -0500
Received: from almesberger.net ([63.105.73.239]:3592 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265557AbSKABZR>; Thu, 31 Oct 2002 20:25:17 -0500
Date: Thu, 31 Oct 2002 22:31:37 -0300
From: Werner Almesberger <wa@almesberger.net>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: What's left over.
Message-ID: <20021031223137.A1421@almesberger.net>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> <20021031031932.GQ15886@ns> <1036098562.12714.50.camel@cog> <20021031184933.B2599@almesberger.net> <1036103533.12714.71.camel@cog> <20021031195442.Y1421@almesberger.net> <1036112051.12713.134.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036112051.12713.134.camel@cog>; from johnstul@us.ibm.com on Thu, Oct 31, 2002 at 04:54:11PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> I thought you were suggesting some crazy ACL
> symlink like: "Make file foo's ACL be the same as file blah's ACL" and
> if I then go and add some untrusted user to blah's ACL it would then
> automatically change foo's ACL.

Well, with "foo" getting the ACL from "bar", changing the ACL of
"bar" would change "foo", but not vice versa. Of course, the idea
is that you're careful when changing "bar", just like you'd be
careful with your SSH keys.

> Eh, as long as the ACLs are per-file, I can't ever accidentally give
> access to a file I didn't mean to. The corner cases of "remove my
> ex-friend from all my files" could be annoying, but could be done w/ the
> equiv of chgrp -r 

chgrp -r gets nasty if you have files which are stored off-line.
On the other hand, using the concept that ACEs add rights, but
never take them away, even an off-line "ACL link target" would
fail on the safe side, by not adding more rights.

> I probably should just go read the specs. Anyone have a pointer, or care
> to explain what the differences are between AFS's ACLs and POSIX ACLs?

I've forgotten most things I knew about AFS ACLs (I used them at
IBM about eight years ago), but http://acl.bestbits.at/ and in
particular http://acl.bestbits.at/cgi-man/acl.5 seem to have
everything about POSIX ACLs. They're not very complicated.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
