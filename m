Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVDDKMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDDKMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 06:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbVDDKMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 06:12:46 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:35293 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261204AbVDDKMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 06:12:35 -0400
X-ME-UUID: 20050404101233884.D7E6B1C00090@mwinf0806.wanadoo.fr
Date: Mon, 4 Apr 2005 12:09:29 +0200
To: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404100929.GA23921@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

<quick sumary>
Current linux kernel source hold undistributable non-free firmware blobs, and
to consider them as mere agregation, a clear licence statement from the
copyright holders of said non-free firmware blobls is needed, read below for
details.
</quick sumary>

Please keep everyone in the CC, as not everyone reads debian-legal or LKML.

Some kernel modules present in the kernel sources as distributed from
ftp.kernel.org present some non-free binary only firmware that gets uploaded
in the target chip by the controler. tg3, qla2xxx, acenix and a couple of
others are example of such modules with non-free firmware blobs.

This is no major problem per see, since, as discussed in this thread :

  http://lists.debian.org/debian-legal/2005/03/msg00283.html

It is obvious in this context that the non-free firmware constitute a mere
aggregation and not an act of linking with the rest of the kernel. This is at
least the consensus that debian has reached with input from the debian-legal
lists, and what we will stand by this.

Naturally even if debian has come to the conclusion that these non-free
firmware blobs are not a violation of the rest of the kernel GPL licence, it
still doesn't make these non-free firmware blobs free software, and thus they
and the drivers which contain it will be removed from debian/main, and put
into the non-free section of our archive.

Now, these non-free firmware are distributed in the same file as the rest of
the module which uses it. This is still ok since it constitute agregation on
a same distribution media, where the distribution media is the file in this
case. 

But these files, as seen in the tg3.c case, have no special mention of the
firmware in the file header, nor are they distinguished in any way from the
rest of the content of that file, which places them de facto under the GPL,
since.

Accordying to the GPL, we thus needs the source files for this non-free
firmware, which is not available, and thus makes the files undistributable.
Even if we would consider these firmware as separate and not covered by the
de-facto GPLing of the files in question, we still would have no licence
allowing us to distribute those non-free firmware blobs, and thus we have
again no right to distribute them as part of the kernel.

The clean solution is to have a small notice in the header of those files or
in the toplevel COPYING file, excluding those firmware blobs from the general
GPLing of the files, and have a small comment inside the files to identify the
firmware blobs as such and again excluding them from the GPL, and possibly a
toplevel listing of all the files wich have such problems.

This is an easy fix, and i believe even those who held the above analysis as
non-sense or whatever will agree that this is something that should be done.
The real problem being that nobody except the copyright holder of those
firmware blobs is legally allowed to make said modification, and thus i bring
this issue to everyone's attention, for comment and feedback, before trying to
reach the copyright holders of those individual firmware blobs asking them to
clarify the situation. I believe many of those read this list anyway, so would
be able to fix the issue or comment on it without further proding needed.

In hopes of quick resolution of these murky legalese issues nobody is really
fond of, 

Friendly,

Sven Luther

