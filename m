Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTJFWfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJFWfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:35:51 -0400
Received: from f20.mail.ru ([194.67.57.52]:23051 "EHLO f20.mail.ru")
	by vger.kernel.org with ESMTP id S261749AbTJFWfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:35:36 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: ralf@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]  '< 0' comparison make sense only with signed variable.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.64.37]
Date: Tue, 07 Oct 2003 02:37:02 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1A6dyQ-0007ek-00.adobriyan-mail-ru@f20.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ax25_ctl.arg is unsigned long

diff -urN a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
--- a/net/ax25/af_ax25.c	2003-09-28 04:51:00.000000000 +0400
+++ b/net/ax25/af_ax25.c	2003-10-07 01:03:08.000000000 +0400
@@ -421,14 +421,10 @@
   		break;
 
   	case AX25_T3:
-  		if (ax25_ctl.arg < 0)
-  			return -EINVAL;
   		ax25->t3 = ax25_ctl.arg * HZ;
   		break;
 
   	case AX25_IDLE:
-  		if (ax25_ctl.arg < 0)
-  			return -EINVAL;
   		ax25->idle = ax25_ctl.arg * 60 * HZ;
   		break;
 

