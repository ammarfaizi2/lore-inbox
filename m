Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWIMG7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWIMG7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWIMG7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:59:49 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:35525 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751642AbWIMG7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:59:48 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 06:59:31 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ee8a8j$gf7$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com> <ee88af$fgo$1@taverner.cs.berkeley.edu> <B7C6636B-03E9-4D4C-AC0E-2898181F419B@mac.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158130771 16871 128.32.168.222 (13 Sep 2006 06:59:31 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 13 Sep 2006 06:59:31 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett  wrote:
>No, git-tar-tree is storing the desired permissions (0666 and 0777)  
>in the tar archive.  This is not a bug, those are actually the  
>permissions we want in the tar archive.

Those may be the permissions *you* want, but they're not the permissions
I suspect many users would prefer.  Take a look at any open-source
project that ships tar archives of their source code.  Do they ship
tarballs of their source code where all the files have 0666 permissions?
Not in my experience.  That should tell you something.

Telling me that this is "by design" is not a very persuasive response
when my claim is that the design is poorly chosen.

>No, it is user-friendly.  This is like distributing programs who use  
>open(..., 0666) when opening globally-readable files.

It's not the same.  There's a reason that most other open-source
projects are careful not to distribute 0666 files in their tar archives.

>o   Do *not* extract kernel trees as root

I don't see anything unreasonable about extracting tarballs from a
trusted source as root (unless, of course, the folks who put together
the tarballs are malicious or careless or can't be trusted).

I don't see any good justification for this other than that the
maintainers of git-tar-tree can't be bothered to store more reasonable
permissions in the tar archive.  It smells like a workaround that is
designed to make the lives of the git-tar-tree programmers easier --
but at the cost of making users lives a little harder.  That's what I
mean when I said that this decision doesn't seem very user-friendly.
