Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUIEUQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUIEUQL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267205AbUIEUQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 16:16:10 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50006 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267212AbUIEUQA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 16:16:00 -0400
Date: Sun, 5 Sep 2004 22:19:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Simplify vmlinux generation
Message-ID: <20040905201903.GA17854@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040905201235.GC16901@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905201235.GC16901@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not posted to lkml:
o Update ver_linux to include current reiserfsprogs (Steven Cole)

--- bk-current/scripts/ver_linux.orig	2004-08-31 22:00:44.506377680 -0600
+++ bk-current/scripts/ver_linux	2004-08-31 22:04:59.844560376 -0600
@@ -37,8 +37,11 @@
 fsck.jfs -V 2>&1 | grep version | sed 's/,//' |  awk \
 'NR==1 {print "jfsutils              ", $3}'
 
-reiserfsck -V 2>&1 | grep reiserfsprogs | awk \
-'NR==1{print "reiserfsprogs         ", $NF}'
+reiserfsck -V 2>&1 | grep reiserfsck | awk \
+'NR==1{print "reiserfsprogs         ", $2}'
+
+fsck.reiser4 -V 2>&1 | grep fsck.reiser4 | awk \
+'NR==1{print "reiser4progs          ", $2}'
 
 xfs_db -V 2>&1 | grep version | awk \
 'NR==1{print "xfsprogs              ", $3}'



