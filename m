Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWGFWcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWGFWcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWGFWcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:32:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:43962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750950AbWGFWb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:31:59 -0400
Date: Thu, 6 Jul 2006 15:28:11 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, stable@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.16.24
Message-ID: <20060706222811.GC2946@kroah.com>
References: <20060706222553.GA2946@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706222553.GA2946@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index da3e313..9b1622f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .23
+EXTRAVERSION = .24
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/kernel/sys.c b/kernel/sys.c
index 105e102..413706a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1802,7 +1802,7 @@ asmlinkage long sys_prctl(int option, un
 			error = current->mm->dumpable;
 			break;
 		case PR_SET_DUMPABLE:
-			if (arg2 < 0 || arg2 > 2) {
+			if (arg2 < 0 || arg2 > 1) {
 				error = -EINVAL;
 				break;
 			}
