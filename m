Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277496AbRJEQ64>; Fri, 5 Oct 2001 12:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277495AbRJEQ6e>; Fri, 5 Oct 2001 12:58:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5392 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277486AbRJEQ6Y>; Fri, 5 Oct 2001 12:58:24 -0400
Date: Fri, 5 Oct 2001 09:58:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
In-Reply-To: <m1zo76xd5w.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0110050952510.1540-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 5 Oct 2001, Eric W. Biederman wrote:
> > The MAP_DENYWRITE rule was added a long time ago because people found actual
> > workable DoS attacks
>
> Do you have any details.  I would like to figure out what it takes to
> export MAP_DENYWRITE safely to userspace.

I think it literally was /var/run/[uw]tmp, and using MAP_DENYWRITE to
disable all logins.

But it pretty much covers _any_ logfiles that are readable (and thus
openable) by users.

> Currently checking to see if the file is executable looks good
> enough.

[ executable by the user in question, not just anybody ]

Yes, I suspect it is.

> The fix for bad permission (during a DOS attack) is either:
> 	chmod correct_permissions foo
> 	lsof foo | xargs kill

Well, if you cannot log in as root, it doesn't much matter what the "fix"
is, so it's better to be safe than sorry.

		Linus

