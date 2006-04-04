Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWDDJ2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWDDJ2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWDDJ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:28:38 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:34690 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932418AbWDDJ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:28:37 -0400
Date: Tue, 4 Apr 2006 11:28:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederman@lnxi.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>, Simon Evans <spse@secret.org.uk>
Subject: [Patch 1/3] Immediatly deprecate blkmtd
Message-ID: <20060404092832.GB12277@wohnheim.fh-wedel.de>
References: <20060404092628.GA12277@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060404092628.GA12277@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate blkmtd.  Reasoning is described in the patch itself.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 Documentation/feature-removal-schedule.txt |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- blkmtd/Documentation/feature-removal-schedule.txt~blkmtd_deprecation	2006-04-04 10:55:42.000000000 +0200
+++ blkmtd/Documentation/feature-removal-schedule.txt	2006-04-04 11:03:56.000000000 +0200
@@ -246,3 +246,17 @@ Why:	The interface no longer has any cal
 Who:	Nick Piggin <npiggin@suse.de>
 
 ---------------------------
+
+What:	blkmtd
+When:	April 2006
+Files:	drivers/mtd/devices/blkmtd.c
+Why:	o An alternative exists that hasn't had  bug report for > 1 year.
+	o Most embedded people tend to use ancient kernels with custom patches
+  	  from mtd cvs and elsewhere, so the 1 year warning period neither
+  	  helps nor hurts them too much.
+	o It's in the way of klibc.  The problems caused by pulling blkmtd
+  	  support are fairly low, while the problems caused by delaying klibc
+  	  can be fairly substantial.  At best, this would be a severe burden
+  	  on hpa's time.
+
+Who:	Joern Engel <joern@wh.fh-wedel.de>
