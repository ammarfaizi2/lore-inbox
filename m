Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTKKIt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTKKIt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:49:56 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1664 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263420AbTKKIty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:49:54 -0500
Date: Tue, 11 Nov 2003 08:53:09 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311110853.hAB8r9dw000384@81-2-122-30.bradfords.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200311110819.hAB8J4A8013284@turing-police.cc.vt.edu>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
 <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk>
 <200311091754.21619.rob@landley.net>
 <200311100850.hAA8oiIX000283@81-2-122-30.bradfords.org.uk>
 <200311110819.hAB8J4A8013284@turing-police.cc.vt.edu>
Subject: Re: Some thoughts about stable kernel development 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Valdis.Kletnieks@vt.edu:
> --==_Exmh_1622051872P
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, 10 Nov 2003 08:50:44 GMT, John Bradford <john@grabjohn.com>  said:
> 
> > cause annoyance to third parties.  Given that, I think a file in the
> > root of the kernel tree, saying something like, "Don't use me on an
> > internet connected machine unless you know what you're doing" would be
> > worth considering.
> 
> OK.. I'll bite.. :)
> 
> What *additional* level of "know what you're doing" is called for, over and
> above the usual "best practices" we wish all net-connected machines implemented?
> 
> Or phrased differently - yes, there's several local-user-gets-root attacks that
> aren't patched.  However, I'm sure that even a tightened down and fully-patched
> system has several ways to do that without leveraging a kernel bug, so the
> question becomes "balance the chances that the attacker has an exploit for the
> kernel bug" against "chance attacker has exploit for set-UID program XYZ".
> 
> Or is the assumption that if you understand how "remote execution of
> arbitrary code as local user" combines with "local user gets root" to
> form the product "you're screwed", sufficient clue is available?

I don't even know why this thread is continuing - I have already
pointed out that I intended to cancel my original post, but hit the
wrong key.  I.E. I had changed my mind about the importance of the
issue.  If you don't belive me, note the face that I hadn't trimmed
the quotes on the original post, and the fact that it was addressed as
a private comment to Linus, anyway, (I hadn't yet removed the CC
list).

Nevertheless, I the point I just brought up is much simpler than you
are making it seem.

My experience, at least, has been that during the development of most
userspace applications, security fixes which apply to both stable and
unstable branches are applied at the same time.  I think users have
come to expect that, even though that is bad practice.

In any case - we work differently, and don't make that fact at all
obvious.  Rather than suggesting we change the way we work, (not
practical), I am suggesting that we educate people, (not easy, but we
can do our bit - provide the information).

The upshot of all this is that an admin who is _generally responsible
and knows what he is doing_, may well be under the impression that
running a development kernel on a network connected box may eat his
filesystem, but that it would not contain _known_ security
vulnerabilities.  Be aware that a compromised box could be used as a
vector for attack on other boxes, including those of innocent third
parties, (E.G. on a datacentre LAN).

A typical admin may decide to run, E.G. a news server or web proxy
server with a development kernel, on the basis that even if the
machine is trashed, it doesn't matter, not being aware of the security
issues.

John.
