Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVH2WYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVH2WYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 18:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVH2WYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 18:24:33 -0400
Received: from mirapoint2.brutele.be ([212.68.199.149]:8805 "EHLO
	mirapoint2.brutele.be") by vger.kernel.org with ESMTP
	id S1751360AbVH2WYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 18:24:33 -0400
Date: Tue, 30 Aug 2005 00:24:17 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/s2io.h - lvalue fix
Message-ID: <20050829222417.GA20292@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
X-Operating-System: Linux debian 2.6.12-1-k7
User-Agent: Mutt/1.5.10i
X-Junkmail-Status: score=10/50, host=mirapoint2.brutele.be
X-Junkmail-SD-Raw: score=unknown, refid=0001.0A090201.43138839.0014-F-L0BeBC04zsV01UPbcJcIKw==,  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?p=3D=C0=F5=08=08?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi all , 

Sorry if I don't send this patch to the maintainer of s2io, but I don't
know who is he.

This patch is based on Kernel 2.6.13 release from the Linus tree.

Is there a process to send patch to the mailing list ?

Best regards, 

Stephane

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
                <stephane.wirtel@gmail.com>



--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="patch_lvalue_s2io.diff"

diff --git a/drivers/net/s2io.h b/drivers/net/s2io.h
--- a/drivers/net/s2io.h
+++ b/drivers/net/s2io.h
@@ -762,8 +762,8 @@ static inline u64 readq(void __iomem *ad
 {
 	u64 ret = 0;
 	ret = readl(addr + 4);
-	(u64) ret <<= 32;
-	(u64) ret |= readl(addr);
+	ret <<= 32;
+	ret |= readl(addr);
 
 	return ret;
 }

--5mCyUwZo2JvN/JJP--

