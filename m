Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWJHPGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWJHPGK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWJHPGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:06:10 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:60813 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751212AbWJHPGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:06:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=Yio19LEsAopXatJWnxPRLo5u7O4Cao2+d9xV4AIAXRmjv+uFaeOyNRSBwXrs+4PQ8J+Gh7952QLOstS4J2dsGgCG++1qgW0kXnrNio9MKxfzCKzcUgEZKYDpPvMrU3k5Gdqxz0RgnfGj8RPSpFlnforGoaqxTaIB1XRbtphT7W8=
Message-ID: <452913DB.4010409@gmail.com>
Date: Sun, 08 Oct 2006 20:36:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor coding style fix
Content-Type: multipart/mixed;
 boundary="------------020304090206080906070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020304090206080906070301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kernel generally follow the style 

if (func()) {
/* failed case */
} else {
/* success */
}


-aneesh

--------------020304090206080906070301
Content-Type: text/x-patch;
 name="sys.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sys.c.diff"

diff --git a/kernel/sys.c b/kernel/sys.c
index 98489d8..55cb77c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -517,7 +517,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_call_cha
 void srcu_init_notifier_head(struct srcu_notifier_head *nh)
 {
 	mutex_init(&nh->mutex);
-	if (init_srcu_struct(&nh->srcu) < 0)
+	if (init_srcu_struct(&nh->srcu))
 		BUG();
 	nh->head = NULL;
 }

--------------020304090206080906070301--
