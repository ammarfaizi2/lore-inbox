Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTFJJ55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbTFJJ5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:57:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26035 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261414AbTFJJyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:54:44 -0400
Date: Tue, 10 Jun 2003 15:41:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-intermezzo
Message-ID: <20030610101121.GG2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610101035.GF2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fixed copy/user problem in lento_symlink where user address was
getting passed to presto_do_symlink.


 fs/intermezzo/vfs.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/intermezzo/vfs.c~cp-user-intermezzo fs/intermezzo/vfs.c
--- linux-2.5.70-ds/fs/intermezzo/vfs.c~cp-user-intermezzo	2003-06-08 14:07:49.000000000 +0530
+++ linux-2.5.70-ds-dipankar/fs/intermezzo/vfs.c	2003-06-08 14:09:28.000000000 +0530
@@ -1236,7 +1236,7 @@ int lento_symlink(const char *oldname, c
                 goto exit_lock;
         }
         error = presto_do_symlink(fset, nd.dentry,
-                                  dentry, oldname, info);
+                                  dentry, from, info);
         path_release(&nd);
         EXIT;
  exit_lock:

_
