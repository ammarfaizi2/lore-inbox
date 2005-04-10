Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVDJQ1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVDJQ1c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 12:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDJQ1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 12:27:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26585 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261510AbVDJQ10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 12:27:26 -0400
Date: Sun, 10 Apr 2005 18:27:23 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410162723.GC26537@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410024157.GE3451@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  so I "released" git-pasky-0.1, my set of patches and scripts upon
Linus' git, aimed at human usability and to an extent a SCM-like usage.

  You can get it at

	http://pasky.or.cz/~pasky/dev/git/git-pasky-base.tar.bz2

and after unpacking and building (make) do

	git pull pasky

to get the latest changes from my branch. If you already have some git
from my branch which can do pulling, you can bring yourself up to date
by doing just

	gitpull.sh pasky

(but this style of usage is deprecated now). Please see the README for
some details regarding usage etc. You can find the changes from the last
announcement in the ChangeLog (the previous announcement corresponds to
commit id 5125d089ad862f16a306b4942155092e1dce1c2d). The most important
change is probably recursive diff addition, and making git ignore the
nsec of ctime and mtime, since it is totally unreliable and likes to
taint random files as modified.

  My near future plans include especially some merge support; I think it
should be rather easy, actually. I'll also add some simple tagging
mechanism. I've decided to postpone the file moving detection, since
there's no big demand for it now. ;-)

  I will also need to do more testing on the linux kernel tree.
Committing patch-2.6.7 on 2.6.6 kernel and then diffing results in

	$ time gitdiff.sh `parent-id` `tree-id` >p
	real    5m37.434s
	user    1m27.113s
	sys     2m41.036s

which is pretty horrible, it seems to me. Any benchmarking help is of
course welcomed, as well as any other feedback.

  BTW, what would be the best (most complete) source for the BK tree
metadata? Should I dig it from the BKCVS gateway, or is there a better
source? Where did you get the sparse git database from, Linus? (BTW, it
would be nice to get sparse.git with the directories as separate.)

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
