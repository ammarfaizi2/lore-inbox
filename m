Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311579AbSCNKhO>; Thu, 14 Mar 2002 05:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311580AbSCNKhE>; Thu, 14 Mar 2002 05:37:04 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17192 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S311579AbSCNKgx>; Thu, 14 Mar 2002 05:36:53 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: Tom Lord <lord@regexps.com>, andrew@pimlott.ne.mediaone.net,
        lm@work.bitmover.com, Geert.Uytterhoeven@sonycom.com, james@and.org,
        lm@bitmover.com, jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions (was Re: linux-2.5.4-pre1 - bitkeeper testing)
In-Reply-To: <20020312223738.GB29832@pimlott.ne.mediaone.net>
	<Pine.GSO.4.21.0203131037240.17582-100000@vervain.sonytel.be>
	<20020313143720.GA32244@pimlott.ne.mediaone.net>
	<20020313082647.Y23966@work.bitmover.com>
	<20020313163045.GA6575@pimlott.ne.mediaone.net>
	<3C8FA608.6040103@namesys.com>
	<200203140939.BAA14739@morrowfield.home>
	<3C905EA4.3050906@namesys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Mar 2002 03:31:06 -0700
In-Reply-To: <3C905EA4.3050906@namesys.com>
Message-ID: <m1y9gvxwyd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:
> Since reiser4 is in feature freeze, let's defer this thread until October, ok?
> It will be a long one I think.....

Playing with ideas is probably reasonable before then.  Especially
the user space API.  A couple of points were made earlier in
this thread that I would like to summarize.

1) For a filesystem level design initially treat version control,
   as the snapshot/backup problem.   This problem everyone
   understands.  If you can get and keep an atomic snapshot of
   your filesystem there are some things that become easier.
2) Allow the ability to mount different versions/snapshots of the filesystem.
   This ties in with the idea of per user namespaces.
3) Don't require you be root to do this stuff.

At that point you are still a long ways from a version control system
like bitkeeper but it looks like a foundation that could productively
be built on.  While at the same time solving a very real user space
problem, and not messing up normal userspace filesystem semantics. 

Eric
