Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVIHWYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVIHWYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVIHWYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:24:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:44478 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965054AbVIHWW6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:58 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: added private family data into w1_slave strucutre.
In-Reply-To: <11262181623003@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:42 -0700
Message-Id: <11262181622645@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: added private family data into w1_slave strucutre.

Add family_data to struct w1_slave.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a45f105ad4b456f99f622642056ae533f70710b7
tree 67bc83922a2bbda6ecf4131ca69ab1626fe9937b
parent 7657ec1fcb69e266ab876af56332d0c484ca6d00
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Wed, 17 Aug 2005 15:19:08 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:27 -0700

 drivers/w1/w1.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -75,6 +75,7 @@ struct w1_slave
 
 	struct w1_master	*master;
 	struct w1_family	*family;
+	void			*family_data;
 	struct device		dev;
 	struct completion	released;
 };

