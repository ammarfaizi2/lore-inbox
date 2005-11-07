Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVKGDQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVKGDQs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVKGDQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:37 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:11925 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932420AbVKGDQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:13 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [Patch 19/20] V4L removal schedule for V4L1 API
Date: Mon, 07 Nov 2005 00:58:11 -0200
Message-Id: <1131333341.25215.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

- States a date for removing V4L1 API

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 Documentation/feature-removal-schedule.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

--- hg.orig/Documentation/feature-removal-schedule.txt
+++ hg/Documentation/feature-removal-schedule.txt
@@ -95,3 +95,18 @@ Why:	This interface has been obsoleted b
 	to link against API-compatible library on top of libnfnetlink_queue 
 	instead of the current 'libipq'.
 Who:	Harald Welte <laforge@netfilter.org>
+
+---------------------------
+
+What:	Video4Linux API 1 ioctls and video_decoder.h from Video devices.
+When:	July 2006
+Why:	V4L1 AP1 was replaced by V4L2 API. during migration from 2.4 to 2.6
+	series. The old API have lots of drawbacks and don't provide enough
+	means to work with all video and audio standards. The newer API is 
+	already available on the main drivers and should be used instead.
+	Newer drivers should use v4l_compat_translate_ioctl function to handle
+	old calls, replacing to newer ones.
+	Decoder iocts are using internally to allow video drivers to
+	communicate with video decoders. This should also be improved to allow
+	V4L2 calls being translated into compatible internal ioctls.
+Who:	Mauro Carvalho Chehab <mchehab@brturbo.com.br>


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

