Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUHIRuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUHIRuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266797AbUHIRuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:50:19 -0400
Received: from mail.convergence.de ([212.84.236.4]:36750 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S266790AbUHIRuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:50:11 -0400
Date: Mon, 9 Aug 2004 19:50:13 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040809175013.GA5567@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040808152936.1ce2eab8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808152936.1ce2eab8.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> boolean-typo-in-dvb.patch
>   boolean typo in DVB

It would be nice if this patch would go into 2.6.8.

And, although the current DVB stuff compiles fine, for correctness
the following patch adds the necessary include for __user annotations.

Thanks,
Johannes


diff -ru linux-2.6.8-rc3.orig/include/linux/dvb/osd.h linux-2.6.8-rc3/include/linux/dvb/osd.h
--- linux-2.6.8-rc3.orig/include/linux/dvb/osd.h	2004-08-09 19:41:14.000000000 +0200
+++ linux-2.6.8-rc3/include/linux/dvb/osd.h	2004-08-09 19:41:55.000000000 +0200
@@ -24,6 +24,8 @@
 #ifndef _DVBOSD_H_
 #define _DVBOSD_H_
 
+#include <linux/compiler.h>
+
 typedef enum {
   // All functions return -2 on "not open"
   OSD_Close=1,    // ()
diff -ru linux-2.6.8-rc3.orig/include/linux/dvb/video.h linux-2.6.8-rc3/include/linux/dvb/video.h
--- linux-2.6.8-rc3.orig/include/linux/dvb/video.h	2004-08-09 19:41:14.000000000 +0200
+++ linux-2.6.8-rc3/include/linux/dvb/video.h	2004-08-09 19:42:07.000000000 +0200
@@ -24,6 +24,8 @@
 #ifndef _DVBVIDEO_H_
 #define _DVBVIDEO_H_
 
+#include <linux/compiler.h>
+
 #ifdef __KERNEL__
 #include <linux/types.h>
 #else
