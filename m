Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVEJCPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVEJCPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 22:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVEJCPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 22:15:42 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:3240 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S261445AbVEJCPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 22:15:35 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [patch 1/6] uml: remove elf.h [ compile-fix, for 2.6.12 ]
To: Andrew Morton <akpm@osdl.org>, blaisorblade@yahoo.it, jdike@addtoit.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
Reply-To: 7eggert@gmx.de
Date: Tue, 10 May 2005 04:15:14 +0200
References: <42q12-7bE-5@gated-at.bofh.it> <42rTb-fj-11@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DVKHF-0004w9-Ua@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> hmm, that's exciting.  How to tell diff and patch to remove a zero-length
> file?

$ md a b c
$ touch a/a
$ echo .>c/a
$ diff -purN a c
diff -purN a/a c/a
--- a/a 2005-05-10 04:08:14.000000000 +0200
+++ c/a 2005-05-10 04:09:17.972505331 +0200
@@ -0,0 +1 @@
+.
$ diff -purN c b
diff -purN c/a b/a
--- c/a 2005-05-10 04:09:17.972505331 +0200
+++ b/a 1970-01-01 01:00:00.000000000 +0100
@@ -1 +0,0 @@
-.
$ cd a
$ patch -p1   # < both patches (c&p)
<snip>
$ ls -l
total 0
-- 
If your dog is barking at the back door and your wife is
yelling at the front door, who do you let in first?
The dog, of course. He'll shut up once you let him in.

