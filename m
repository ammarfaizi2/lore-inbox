Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTKYRMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTKYRMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:12:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54010 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262747AbTKYRMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:12:38 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Date: Tue, 25 Nov 2003 11:09:07 -0600
User-Agent: KMail/1.5
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <3FC387A0.8010600@backtobasicsmgmt.com>
In-Reply-To: <3FC387A0.8010600@backtobasicsmgmt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311251109.07831.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 November 2003 10:47, Kevin P. Fleming wrote:
> Joe Thornber wrote:
> > Make the version-4 ioctl interface the default kernel configuration
> > option. If you have out of date tools you will need to use the v1
> > interface.
>
> Actually, isn't the proper way to say this "if your tools are older than
> X and/or were _not_ built against recent 2.6 headers you need to use the
> v1 interface"?
>
> Also, if you're going to change the default you should change the help
> text correspondingly.

How's this look?

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/


--- a/drivers/md/Kconfig	2003-11-23 19:31:11.000000000 -0600
+++ b/drivers/md/Kconfig	2003-11-25 11:07:00.000000000 -0600
@@ -138,9 +138,11 @@
 config DM_IOCTL_V4
 	bool "ioctl interface version 4"
 	depends on BLK_DEV_DM
+	default y
 	---help---
-	  Recent tools use a new version of the ioctl interface, only
-          select this option if you intend using such tools.
+	  Recent tools use this new version of the ioctl interface. Only
+	  select N for this option if you use out-of-date tools that weren't
+	  compiled for this interface (e.g. LVM2 prior to v2.00.00).
 
 endmenu
 

