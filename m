Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274289AbRIYAlP>; Mon, 24 Sep 2001 20:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274292AbRIYAlH>; Mon, 24 Sep 2001 20:41:07 -0400
Received: from ns.marxmeier.com ([194.64.71.4]:38670 "EHLO e35.marxmeier.com")
	by vger.kernel.org with ESMTP id <S274289AbRIYAk4>;
	Mon, 24 Sep 2001 20:40:56 -0400
Message-ID: <3BAFD2B0.CD8193DB@marxmeier.com>
Date: Tue, 25 Sep 2001 02:41:20 +0200
From: Michael Marxmeier <mike@marxmeier.com>
Organization: Marxmeier Software AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] cpia.c (2.4.9-ac)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My CPIA based camera ceased working with 2.4.9-ac9. The patch 
below corrects a small thinko (still present with ac15).

--- cpia.c.orig	Tue Sep 25 01:52:08 2001
+++ cpia.c	Tue Sep 25 01:52:33 2001
@@ -2871,7 +2871,7 @@
 
 		/* set video size */
 		video_size = match_videosize(vm.width, vm.height);
-		if (cam->video_size < 0) {
+		if (video_size < 0) {
 			retval = -EINVAL;
 			break;
 		}


Michael

-- 
Michael Marxmeier           Marxmeier Software AG
E-Mail: mike@marxmeier.com  Besenbruchstrasse 9
Phone : +49 202 2431440     42285 Wuppertal, Germany
Fax   : +49 202 2431420     http://www.marxmeier.com/
