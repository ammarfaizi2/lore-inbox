Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVGOXZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVGOXZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 19:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262053AbVGOXZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 19:25:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52165 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262043AbVGOXY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 19:24:59 -0400
Message-ID: <42D83D77.4030107@us.ibm.com>
Date: Fri, 15 Jul 2005 17:49:27 -0500
From: Linda Xie <lxiep@us.ibm.com>
Reply-To: lxiep@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, zh-cn, zh
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-scsi@vger.kernel.org, Dave C Boutcher <sleddog@us.ibm.com>,
       linux-kernel@vger.kernel.org, Santiago Leon <santil@us.ibm.com>
Subject: [PATCH] scsi/ibmvscsi/srp.h: Fix a wrong type code used for SRP_LOGIN_REJ
Content-Type: multipart/mixed;
 boundary="------------070108040303040003060809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070108040303040003060809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

This patch fixes srp.h which uses 0x80 for SRP_LOGIN_REJ instead of 
0xc2.  Please apply.

Thanks,

Linda

Signed-off-by: Linda Xie <lxie@us.ibm.com

--------------070108040303040003060809
Content-Type: text/plain;
 name="srp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="srp.patch"

diff -X ../dontdiff -purN large-sg/drivers/scsi/ibmvscsi/srp.h srp/drivers/scsi/ibmvscsi/srp.h
--- large-sg/drivers/scsi/ibmvscsi/srp.h	2005-06-24 17:32:27.000000000 -0500
+++ srp/drivers/scsi/ibmvscsi/srp.h	2005-07-15 17:36:45.000000000 -0500
@@ -35,7 +35,7 @@
 enum srp_types {
 	SRP_LOGIN_REQ_TYPE = 0x00,
 	SRP_LOGIN_RSP_TYPE = 0xC0,
-	SRP_LOGIN_REJ_TYPE = 0x80,
+	SRP_LOGIN_REJ_TYPE = 0xC2,
 	SRP_I_LOGOUT_TYPE = 0x03,
 	SRP_T_LOGOUT_TYPE = 0x80,
 	SRP_TSK_MGMT_TYPE = 0x01,

--------------070108040303040003060809--

