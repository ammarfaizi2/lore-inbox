Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264855AbUAOBB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUAOBB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:01:56 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4763 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264855AbUAOBBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:01:55 -0500
Subject: Re: [PATCH] Same keyboard.c as in 2.6.0
From: Omkhar Arasaratnam <iamroot@ca.ibm.com>
To: Markus =?ISO-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1074124061.1278.5.camel@midux>
References: <1074124061.1278.5.camel@midux>
Content-Type: text/plain
Message-Id: <1074127819.16754.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 19:50:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus, 

I think you just need this (posted earlier in the list) its just the
character maps that need fixing:

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c Sun Jan 11 19:42:55 2004
+++ b/drivers/char/keyboard.c Sun Jan 11 19:42:55 2004
@@ -941,8 +941,8 @@
       32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
       48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
       64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
-      80, 81, 82, 83, 84, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
-     284,285,309,311,312, 91,327,328,329,331,333,335,336,337,338,339,
+      80, 81, 82, 83, 43, 93, 86, 87, 88, 94, 95, 85,259,375,260, 90,
+     284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
      367,288,302,304,350, 89,334,326,116,377,109,111,126,347,348,349,
      360,261,262,263,298,376,100,101,321,316,373,286,289,102,351,355,
      103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,


-- 
Omkhar

