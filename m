Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUKFJHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUKFJHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 04:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUKFJHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 04:07:22 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:11648 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261342AbUKFJHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 04:07:10 -0500
X-OB-Received: from unknown (205.158.62.182)
  by wfilter.us4.outblaze.com; 6 Nov 2004 09:07:09 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Sat, 06 Nov 2004 04:07:09 -0500
Subject: Re: support of older compilers
X-Originating-Ip: 172.172.217.214
X-Originating-Server: ws1-6.us4.outblaze.com
Message-Id: <20041106090709.396FA1CE305@ws1-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You found a compiler bug, so you reported
>it as a bug against
>glibc?

You don't think it's possible that a glibc bug
could cause unexpected behavior in a gcc that is
using the glibc libraries?

I assure you it is. gcc-2.95.3 failed compiling
file.c from strace-4.4.1 when running with glibc-2.3.2
as it's libc, while it compiles it just fine when
running with glibc-2.2.5 as it's libc. (I included
this information and the compile log in my bug
report to the linux distributor.)

I don't know whether glibc-2.3.2 *really*
had the bug or whether gcc-2.95.3 had some
dodgy workaround for a bug in earlier glibc2
versions that fixing a bug in glibc-2.3.2
then exposed. Or if any of the glibc vendor
patches were involved (something that should
probably be sorted out before deciding to
file the bug report to gcc-bug@, so as not
to unnecessarily waste the time of gcc
maintainers).

Anyway, that's kind of beside the point.
It was merely an example of how a user
might come to decline an "obvious" gcc upgrade.

I guess what I was trying to say is that users
compiling the kernel with older gcc versions is
less a function of user perversity in refusing to
modernize their tools than it is a result of focus.

What problem is the user trying to solve while
using linux? Solving problems usually requires
eliminating variables that may present obstacles
to arriving at a solution, whether that solution
is working production code, some statistical result,
a document that displays correctly, correctly routed
network flows, whatever.

So users arrive at a relatively stable compiler,
they stop upgrading and use that. They find a
kernel that stays up for a week with no oops
reports or other wierdness, they use that. They
will periodically upgrade the compiler, libc,
kernel, etc, when they have a little spare time,
to take advantage of security fixes, new features,
better performance, whatever, *as long as the upgrade
does not become another variable in the problem that
the user is trying to solve*.

If it does turn out to be a variable (unstable
or in some other way unreliable), they toss it
and go back to the old version, because eliminating
variables until they arrive at the solution to their
problem is what they do. Any other method ends up
in combinatorial hell, and they never find a solution
to their problem except by luck.

Many are quite willing to test new versions, report
bugs, send in patches, etc, just to contribute, but
if their main focus is on other problems, they go back
to the  last stable version right away for their
everyday work.

This is not perverse, selfish, or uncooperative
behavior, it's merely normal problem-solving
methodology. On what basis would one expect
anything else from such a large user base?

-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

