Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262733AbVDHIAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbVDHIAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVDHH6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:58:12 -0400
Received: from coderock.org ([193.77.147.115]:9696 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262740AbVDHHvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:14 -0400
Subject: [patch 4/8] serial/icom: Remove custom msescs_to_jiffies() macro
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, tklauser@nuerscht.ch
From: domen@coderock.org
Date: Fri, 08 Apr 2005 09:51:00 +0200
Message-Id: <20050408075100.ADAC71F3A4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove the MSECS_TO_JIFFIES() macro because msescs_to_jiffies() from
jiffies.h should be used. The macro isn't referenced anywhere anyway.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/serial/icom.h |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/serial/icom.h~msecs_to_jiffies-drivers_serial_icom.h drivers/serial/icom.h
--- kj/drivers/serial/icom.h~msecs_to_jiffies-drivers_serial_icom.h	2005-04-05 12:57:56.000000000 +0200
+++ kj-domen/drivers/serial/icom.h	2005-04-05 12:57:56.000000000 +0200
@@ -286,5 +286,3 @@ struct lookup_int_table {
 	u32	__iomem *global_int_mask;
 	unsigned long	processor_id;
 };
-
-#define MSECS_TO_JIFFIES(ms) (((ms)*HZ+999)/1000)
_
