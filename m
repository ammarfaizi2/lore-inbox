Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275480AbTHJISx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 04:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275481AbTHJISw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 04:18:52 -0400
Received: from mars.mj.nl ([81.91.1.49]:38543 "HELO mars.mj.nl")
	by vger.kernel.org with SMTP id S275480AbTHJISm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 04:18:42 -0400
Subject: A mount that follows a symlink at /etc/mtab
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1060503519.1499.48.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 10:18:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the past wishes have been expressed here for a mount program
that would follow a symbolic link at /etc/mtab.  Then, if the root
filesystem is read-only, /etc/mtab can be made a symlink into a
filesystem that is writable.  (Of course, that would mean that the
mtab could not be written until the latter filesystem was mounted;
but this problem can be overcome with a "mount -n", "mount -f"
sequence.)

I have patched the latest mount release to follow a symlink at
/etc/mtab .  Unlike some earlier patches that have been posted
elsewhere, this one follows a symlink chain to the end and makes
mount create lockfiles and temporary files in the directory of
the link target.  The patch is available via this page:
    http://panopticon.csustan.edu/thood/readonly-root.html

The new version of the mount program (2.12pre) to which it applies
is available here:
    ftp://ftp.win.tue.nl/pub/home/aeb/linux-local/utils/util-linux/

If you are interested in seeing the mount program enhanced in this
way then please try it out and let me know whether or not there are
any problems.  If people can confirm that I haven't introduced any
bugs (I have tried to be careful) then I'll submit this patch
upstream.
--
Thomas Hood

