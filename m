Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262086AbVFWKQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbVFWKQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVFWKOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:14:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43783 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262086AbVFWKIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:08:30 -0400
Date: Thu, 23 Jun 2005 12:08:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] schedule the obsolete raw driver for removal
Message-ID: <20050623100821.GE3749@stusta.de>
References: <20050521001925.GQ5112@stusta.de> <20050521053558.GA23542@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521053558.GA23542@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 10:35:58PM -0700, Greg KH wrote:
> On Sat, May 21, 2005 at 02:19:25AM +0200, Adrian Bunk wrote:
> > Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> > obsolete.
> > 
> > It seems to be time to remove it.
> 
> As much as I would like to agree with you, no, not yet.  Mark it as
> going to go away in the Documenation/feature-removal.txt file 6-8 months
> from now (or longer if people object, but no longer than a year) and
> then after that time expires, we can delete it.

Patch below.

> thanks,
> 
> greg k-h

cu
Adrian


<--  snip  -->


Since kernel 2.6.3 the Kconfig text explicitely stated this driver was
obsolete.

It seems to be time to schedule it's removal.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm1-full/Documentation/feature-removal-schedule.txt.old	2005-06-23 12:01:40.000000000 +0200
+++ linux-2.6.12-mm1-full/Documentation/feature-removal-schedule.txt	2005-06-23 12:04:09.000000000 +0200
@@ -45,0 +46,8 @@
+What:	RAW driver (CONFIG_RAW_DRIVER)
+When:	December 2005
+Why:	declared obsolete since kernel 2.6.3
+	O_DIRECT can be used instead
+Who:	Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
--- linux-2.6.12-mm1-full/drivers/char/Kconfig.old	2005-06-23 12:04:20.000000000 +0200
+++ linux-2.6.12-mm1-full/drivers/char/Kconfig	2005-06-23 12:04:46.000000000 +0200
@@ -943,2 +943,2 @@
-          The raw driver is deprecated and may be removed from 2.7
-          kernels.  Applications should simply open the device (eg /dev/hda1)
+          The raw driver is deprecated and will be removed soon.
+          Applications should simply open the device (eg /dev/hda1)

