Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUJHXVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUJHXVr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJHXVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:21:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:35727 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266195AbUJHXUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:20:43 -0400
Date: Fri, 8 Oct 2004 16:20:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041008162028.U2357@build.pdx.osdl.net>
References: <1097269108.1442.53.camel@krustophenia.net> <20041008144539.K2357@build.pdx.osdl.net> <1097272140.1442.75.camel@krustophenia.net> <20041008145252.M2357@build.pdx.osdl.net> <1097273105.1442.78.camel@krustophenia.net> <20041008151911.Q2357@build.pdx.osdl.net> <20041008152430.R2357@build.pdx.osdl.net> <1097276726.1442.82.camel@krustophenia.net> <20041008161205.T2357@build.pdx.osdl.net> <1097277337.1442.90.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1097277337.1442.90.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 08, 2004 at 07:15:37PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> I think the patch is reversed.  It does the opposite of what you say in
> both cases ;-).  I fixed these by hand.  

Ooops, thanks.

- rm unecessary #ifdef CONFIG_SECURITY

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


--- security/realtime.c~static_exit	2004-10-08 16:12:14.199873592 -0700
+++ security/realtime.c	2004-10-08 16:15:43.915991896 -0700
@@ -28,8 +28,6 @@
 #include <linux/sysctl.h>
 #include <linux/moduleparam.h>
 
-#ifdef CONFIG_SECURITY
-
 #define RT_LSM "Realtime LSM "		/* syslog module name prefix */
 #define RT_ERR "Realtime: "		/* syslog error message prefix */
 
@@ -231,5 +229,3 @@
 
 MODULE_DESCRIPTION("Realtime Capabilities Security Module");
 MODULE_LICENSE("GPL");
-
-#endif	/* CONFIG_SECURITY */
