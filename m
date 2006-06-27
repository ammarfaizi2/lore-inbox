Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWF0UVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWF0UVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWF0UVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:21:10 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:49025 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030344AbWF0UVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:21:07 -0400
Message-Id: <20060627201811.894713000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:24 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Richard Purdie <rpurdie@rpsys.net>, Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH 24/25] Input: return correct size when reading modalias attribute
Content-Disposition: inline; filename=input-return-correct-size-when-reading-modalias-attribute.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Richard Purdie <rpurdie@rpsys.net>

return correct size when reading modalias attribute

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.17.1.orig/drivers/input/input.c
+++ linux-2.6.17.1/drivers/input/input.c
@@ -629,7 +629,7 @@ static ssize_t input_dev_show_modalias(s
 
 	len = input_print_modalias(buf, PAGE_SIZE, id, 1);
 
-	return max_t(int, len, PAGE_SIZE);
+	return min_t(int, len, PAGE_SIZE);
 }
 static CLASS_DEVICE_ATTR(modalias, S_IRUGO, input_dev_show_modalias, NULL);
 

--
