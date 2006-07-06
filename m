Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWGFWc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWGFWc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 18:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWGFWc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 18:32:29 -0400
Received: from ns.suse.de ([195.135.220.2]:47290 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750956AbWGFWc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 18:32:28 -0400
Date: Thu, 6 Jul 2006 15:28:41 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.17.4
Message-ID: <20060706222841.GD2946@kroah.com>
References: <20060706222704.GB2946@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706222704.GB2946@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 8c72521..abcf2d7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Crazed Snow-Weasel
 
 # *DOCUMENTATION*
diff --git a/kernel/sys.c b/kernel/sys.c
index 0b6ec0e..59273f7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1991,7 +1991,7 @@ asmlinkage long sys_prctl(int option, un
 			error = current->mm->dumpable;
 			break;
 		case PR_SET_DUMPABLE:
-			if (arg2 < 0 || arg2 > 2) {
+			if (arg2 < 0 || arg2 > 1) {
 				error = -EINVAL;
 				break;
 			}
