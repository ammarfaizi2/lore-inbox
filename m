Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUHXBHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUHXBHW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUHWTYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:24:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:64195 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267186AbUHWSgn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:43 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286087695@kroah.com>
Date: Mon, 23 Aug 2004 11:34:47 -0700
Message-Id: <10932860873192@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.26, 2004/08/06 15:28:47-07:00, johnpol@2ka.mipt.ru

[PATCH] w1: Changed printing format for slave names.

%llx -> %012llx
%x -> %02x

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-08-23 11:04:08 -07:00
+++ b/drivers/w1/w1.c	2004-08-23 11:04:08 -07:00
@@ -319,11 +319,11 @@
 	sl->dev.release = &w1_slave_release;
 
 	snprintf(&sl->dev.bus_id[0], sizeof(sl->dev.bus_id),
-		  "%x-%llx",
+		  "%02x-%012llx",
 		  (unsigned int) sl->reg_num.family,
 		  (unsigned long long) sl->reg_num.id);
 	snprintf (&sl->name[0], sizeof(sl->name),
-		  "%x-%llx",
+		  "%02x-%012llx",
 		  (unsigned int) sl->reg_num.family,
 		  (unsigned long long) sl->reg_num.id);
 

