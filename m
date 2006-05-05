Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751682AbWEEUc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbWEEUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWEEUc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:32:56 -0400
Received: from [151.97.230.9] ([151.97.230.9]:9948 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751682AbWEEUc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:32:56 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] device core: remove redundant call to device_initialize.
Date: Fri, 05 May 2006 17:39:08 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Message-Id: <20060505153907.12756.23295.stgit@zion.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by alpha.home.local id k45KXwU5031109

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

platform_device_add calls device_register which calls then again
device_initialize, redundantly.

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 drivers/base/platform.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 83f5c59..b0d9bd4 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -317,7 +317,6 @@ EXPORT_SYMBOL_GPL(platform_device_del);
  */
 int platform_device_register(struct platform_device * pdev)
 {
-	device_initialize(&pdev->dev);
 	return platform_device_add(pdev);
 }
 EXPORT_SYMBOL_GPL(platform_device_register);
