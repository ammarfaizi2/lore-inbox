Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVH3RFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVH3RFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVH3RFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:05:10 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:19758 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S932151AbVH3RFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:05:09 -0400
Date: Tue, 30 Aug 2005 19:05:02 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Message-ID: <20050830170502.GA10694@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090201.43148EE2.006D-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi all, 

Here is the first patch for kernel 2.6.13 from Linus tree.



-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>



--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="patch_remove_deprecated_check_region.diff"

diff --git a/kernel/resource.c b/kernel/resource.c
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -465,21 +465,6 @@ struct resource * __request_region(struc
 
 EXPORT_SYMBOL(__request_region);
 
-int __deprecated __check_region(struct resource *parent, unsigned long start, unsigned long n)
-{
-	struct resource * res;
-
-	res = __request_region(parent, start, n, "check-region");
-	if (!res)
-		return -EBUSY;
-
-	release_resource(res);
-	kfree(res);
-	return 0;
-}
-
-EXPORT_SYMBOL(__check_region);
-
 void __release_region(struct resource *parent, unsigned long start, unsigned long n)
 {
 	struct resource **p;

--ikeVEW9yuYc//A+q--

