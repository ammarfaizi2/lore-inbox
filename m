Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031371AbWLEU7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031371AbWLEU7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031382AbWLEU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:59:18 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:50062 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031369AbWLEU7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:59:17 -0500
Date: Tue, 5 Dec 2006 21:52:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 12/35] Unionfs: Documentation
In-Reply-To: <11652354701616-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052144320.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354701616-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+++ b/Documentation/filesystems/unionfs/00-INDEX
>@@ -0,0 +1,8 @@
>+00-INDEX
>+	- this file.
>+concepts.txt
>+	- A brief introduction of concepts
>+rename.txt
>+	- Information regarding rename operations
>+usage.txt
>+	- Usage & known limitations

Try "and", & is so... 'lazy'.


>+Since 'foo' is stored on a read-only branch, it cannot be removed. A whiteout
>+is used to remove the name 'foo' from the unified namespace. Again, since
>+branch 1 is read-only, the whiteout cannot be created there. So, we try on a
>+higher priority (lower numerically) branch. And there we create the whiteout.

higher priority (numerically lower) branch and create the whiteout there.
(Starting a sentence with 'and' is like telling fairytales^W stories.)

>+solution is to take the instance from the highest priority (lowest numerical
>+value) and "hide" the others.

(numerically lowest value)

>+When a change is made to the contents of a file's data or meta-data, they
>+have to be stored somewhere. The best way is to create a copy of the
>+original file on a branch that is writable, and then redirect the write
>+though to this copy. The copy must be made on a higher priority branch so
>+that lookup & readdir return this newer "version" of the file rather than
>+the original (see duplicate elimination).

s/&/and/g;

>+Modifying a Unionfs branch directly, while the union is mounted is currently
>+unsupported.

Either:
  Modifying a Unionfs branch directly while the union
  is mounted is currently unsupported.
Or:
  Modifying a Unionfs branch directly, while the union
  is mounted, is currently unsupported.

>  Any such change can cause Unionfs to oops, however it could even
>+RESULT IN DATA LOSS.

Or stay silent (-> silent data corruption / loss)

>+Unionfs shouldn't use lookup_one_len on the underlying fs as it confuses

For written text, non-shortened forms (should not) are preferred. At least
that's (<- that's texified speech not documentation) what we were told back in
scool :p

>+NFS. Currently, unionfs_lookup passes lookup intents to the lower

  should not use lookup_one_len() [...] Currently, unionfs_lookup()

most doc add () to clarify it is a function.

>+filesystem, this eliminates part of the problem. The remaining calls to
>+lookup_one_len may need to be changed to pass an intent.

~

	-`J'
-- 
