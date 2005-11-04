Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVKDS3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKDS3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 13:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVKDS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 13:29:22 -0500
Received: from fmr18.intel.com ([134.134.136.17]:25290 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750765AbVKDS3V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 13:29:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [-mm patch] drivers/char/tlclk.c: make two functions static
Date: Fri, 4 Nov 2005 10:28:17 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A8470BC1C943@orsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [-mm patch] drivers/char/tlclk.c: make two functions static
thread-index: AcXhPZkpMVQDm+YCTD2CU90Tz6c1hQAL7xAQ
From: "Gross, Mark" <mark.gross@intel.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 04 Nov 2005 18:28:18.0342 (UTC) FILETIME=[870D7C60:01C5E16D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!  I'll get these into the then next patch update!

I'm surprised those got missed.

--mgross

>-----Original Message-----
>From: Adrian Bunk [mailto:bunk@stusta.de]
>Sent: Friday, November 04, 2005 4:45 AM
>To: Gross, Mark
>Cc: linux-kernel@vger.kernel.org
>Subject: [-mm patch] drivers/char/tlclk.c: make two functions static
>
>This patch makes two needlessly global functions static.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>---
>
> char/tlclk.c |    8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>--- linux-2.6.14-rc5-mm1-full/drivers/char/tlclk.c.old	2005-11-04
>11:18:45.000000000 +0100
>+++ linux-2.6.14-rc5-mm1-full/drivers/char/tlclk.c	2005-11-04
>11:19:21.000000000 +0100
>@@ -225,8 +225,8 @@
> 	return 0;
> }
>
>-ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
>-		loff_t *f_pos)
>+static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t
count,
>+			  loff_t *f_pos)
> {
> 	if (count < sizeof(struct tlclk_alarms))
> 		return -EIO;
>@@ -241,8 +241,8 @@
> 	return  sizeof(struct tlclk_alarms);
> }
>
>-ssize_t tlclk_write(struct file *filp, const char __user *buf, size_t
count,
>-	    loff_t *f_pos)
>+static ssize_t tlclk_write(struct file *filp, const char __user *buf,
>+			   size_t count, loff_t *f_pos)
> {
> 	return 0;
> }

