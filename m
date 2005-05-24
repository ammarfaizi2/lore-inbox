Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVEXLWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVEXLWC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVEXLSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:18:51 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:22213 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262004AbVEXJTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:19:33 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091930.25477F9FE@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:19:30 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 1D584FB7C

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:50 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261302AbVEXGrF (ORCPT <rfc822;chiakotay@nexlab.it>);

	Tue, 24 May 2005 02:47:05 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEXGrF

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Tue, 24 May 2005 02:47:05 -0400

Received: from fire.osdl.org ([65.172.181.4]:42880 "EHLO smtp.osdl.org")

	by vger.kernel.org with ESMTP id S261302AbVEXGqf (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Tue, 24 May 2005 02:46:35 -0400

Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])

	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O6kTjA025713

	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);

	Mon, 23 May 2005 23:46:29 -0700

Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])

	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O6kScg012582;

	Mon, 23 May 2005 23:46:28 -0700

Date:	Mon, 23 May 2005 23:48:33 -0700 (PDT)

From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates

In-Reply-To: <4292C8EF.3090307@pobox.com>

Message-ID: <Pine.LNX.4.58.0505232343260.2307@ppc970.osdl.org>

References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>

 <4292C8EF.3090307@pobox.com>

MIME-Version: 1.0

Content-Type: TEXT/PLAIN; charset=US-ASCII

X-Spam-Status: No, hits=0 required=5 tests=

X-Spam-Checker-Version:	SpamAssassin 2.63-osdl_revision__1.40__

X-MIMEDefang-Filter: osdl$Revision: 1.109 $

X-Scanned-By: MIMEDefang 2.36

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org





On Tue, 24 May 2005, Jeff Garzik wrote:
> 
> You are getting precisely the same thing you got under BitKeeper:  pull 
> from X, you get my tree, which was composed from $N repositories.  The 
> tree you pull was created by my running 'bk pull' locally $N times.

No. Under BK, you had DIFFERENT TREES.

What does that mean? They had DIFFERENT NAMES.

Which meant that the commit message was MEANINGFUL.

> Ultimately, you appear to be complaining about:
> 
> * your own git-pull-script, which doesn't record the $2 (branch) 
> argument in the commit message.

Yes, because _my_ pull script is meant to work with the way _I_ have told 
people (including you) they should work.

The fact that you mush everything up in one tree _despite_ me having told 
you that isn't a good thing to do is the problem.

Git can technically do it, but then you shouldn't use my scripts, which 
aren't written for that behaviour.

> Hey, I didn't write git-pull-script, I just use it :)

You don't use it, you MIS-use it. Which is what I'm complaining about.

> Switching heads around?  It sounds like you did not pull from the branch 
> I mentioned.

No, I pulled exactly from the head you mentioned.

In fact, go look at YOUR OWN changelog. And then compare that changelog to 
the changelog you had when you used BK, and realize that IT IS NOT AT ALL 
EQUIVALENT. You used to have valid changelogs, even for the merge heads. 
You don't any more:

	Automatic merge of /spare/repo/netdev-2.6/.git
	Automatic merge of /spare/repo/netdev-2.6/.git
	Automatic merge of /spare/repo/netdev-2.6/.git
	Automatic merge of /spare/repo/netdev-2.6/.git
	Merge of /spare/repo/netdev-2.6/.git

See a pattern?

Your BK usage was equivalent to having multiple GIT repositories.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

