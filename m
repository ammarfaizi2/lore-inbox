Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUHZSef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUHZSef (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUHZSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:33:56 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:22734 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S269320AbUHZS0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:26:53 -0400
From: margitsw@t-online.de (Margit Schubert-While)
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core patches for 2.6.9-rc1
Date: Thu, 26 Aug 2004 20:15:35 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HjiLBU+F52+rs70"
Message-Id: <200408262015.35552.margitsw@t-online.de>
X-ID: rAYvxuZCresljpFR-qUvxtprAVOU8jixhgpAwsWyvL0qkNKLcHreg+
X-TOI-MSGID: f541d7df-d6e5-4baf-8eb4-28bf1cb14174
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HjiLBU+F52+rs70
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jean scribeth :
> Except lm85, but this should be fixed

Indeed, patch attached.

Margit



--Boundary-00=_HjiLBU+F52+rs70
Content-Type: text/x-diff;
  charset="us-ascii";
  name="lm85class.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lm85class.patch"

diff -Naur linux-2.6.9rc1/drivers/i2c/chips/lm85.c linux-2.6.9-rc1msw/drivers/i2c/chips/lm85.c
--- linux-2.6.9rc1/drivers/i2c/chips/lm85.c	2004-08-26 19:42:54.000000000 +0200
+++ linux-2.6.9-rc1msw/drivers/i2c/chips/lm85.c	2004-08-26 19:45:23.000000000 +0200
@@ -707,6 +707,8 @@
 
 int lm85_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
 	return i2c_detect(adapter, &addr_data, lm85_detect);
 }
 

--Boundary-00=_HjiLBU+F52+rs70--

