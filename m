Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbTA3C4b>; Wed, 29 Jan 2003 21:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTA3C4b>; Wed, 29 Jan 2003 21:56:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41226 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267306AbTA3C4a>; Wed, 29 Jan 2003 21:56:30 -0500
Date: Wed, 29 Jan 2003 22:03:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC] Change sendfile header
Message-ID: <Pine.LNX.3.96.1030129215509.7114C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suggest that the header holding the prototype for sendfile should not be
in unistd.h because:

1 - sendfile is not in SuS, an is extremely non-standard
2 - there is a sendfile in BSD and it's totally different
3 - there is no man page for sendfile in Solaris, but there is a
    definition in one of the libraries which is not Linux compatible
4 - just putting the "not portable" warning in the man page to counteract
    the impression given by the <unistd.h> is not enough, programmers
    usually only read the man page  to get the args right.

Since Linux sendfile is totally applicable only to Linux, it would seem
that a better name for the header file, like linux/sendfile.h, would be
better. This has the advantage of not breaking executables, and requiring
use of a header file which makes it much harder to overlook the
portability issue.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

