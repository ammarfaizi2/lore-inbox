Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVEHEe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVEHEe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 00:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbVEHEe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 00:34:56 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:57979 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262812AbVEHEey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 00:34:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=jJq1VOrB6CtwVeoSr6n/KgK2P7r3Fr6EseKADuyar8P8gI+5qRbbtbHbVUbNeYVh2SB0KPRt1DHPXLkgb7He/G65WB5yqRH8bwcIQowpex+NX55TKdIwTHe5MethbYX3ofgR7nCwpPWmHxeMv7CQahP2c4gTuRSbLNdCch3pSkU=
Message-ID: <427D96E0.8030902@gmail.com>
Date: Sun, 08 May 2005 00:34:40 -0400
From: Keenan Pepper <keenanpepper@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] Bring back Tux on Chips 65550 framebuffer
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see any reason why the framebuffer should need to be cleared, 
and it makes Tux vanish.

--- drivers/video/chipsfb.orig.c	2005-04-30 14:02:04.872866744 -0400
+++ drivers/video/chipsfb.c	2005-05-08 00:29:30.618216232 -0400
@@ -423,9 +423,6 @@
  	pmu_register_sleep_notifier(&chips_sleep_notifier);
  #endif /* CONFIG_PMAC_PBOOK */

-	/* Clear the entire framebuffer */
-	memset(p->screen_base, 0, 0x100000);
-
  	pci_set_drvdata(dp, p);
  	return 0;
  }


