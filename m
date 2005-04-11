Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVDKN6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVDKN6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDKN6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:58:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36736 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261794AbVDKN6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:58:00 -0400
Date: Mon, 11 Apr 2005 15:57:58 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050411135758.GA3524@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411015852.GI5902@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  here goes git-pasky-0.3, my set of patches and scripts upon
Linus' git, aimed at human usability and to an extent a SCM-like usage.

  If you already have a previous git-pasky version, just git pull pasky
to get it (but see below!!!). Otherwise, you can get it from:

	http://pasky.or.cz/~pasky/dev/git/

  Please see the README there and/or the parent post for detailed
instructions. You can find the changes from the last announcement
in the ChangeLog (releases have separate commits so you can find them
easily; they are also tagged for purpose of diffing etc).

  This release is mainly focused on bugfixes. Especially, it fixes git
diff, which was totally broken in the previous release and would only
diff every other file (forgot to remove one shift from the times when
changes were reported two-line from diff-tree). Very sorry about that.

  This implies that git pull was broken too, though - if you pulled
tracked branch, git diff wouldn't produce the complete diff for patch to
apply. If you didn't do any local changes, it is fortunately easy to
repair:

	git diff | patch -p0 -R

  (The unapplied changes appear as reverted in your local tree when
compared with the cache.) You will need to edit the diff if you did
some local changes.

  Other change breaking some compatibility is regarding commit
environment variables - s/COMMITTER_*/AUTHOR_*/. Otherwise it is usual
bunch of merges with Linus and some really minor stuff. Oh, and make
install works.

  One annoying thing is rsync error when pulling from Linus - it tries
to sync the tags/ directory and I don't know how to safely silence it
except throwing away all stderr. I will probably make it fetch the list
of .dircache and rsync only things which are really there.

  Any feedback/opinions/suggestions/patches (especially patches) are
welcome. You can also stop by at #git either on FreeNode or on OTFC (I
will be around only from 20:00 CET on, though).

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
