Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVCLRol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVCLRol (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVCLRol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:44:41 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:13214 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261980AbVCLRoj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:44:39 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-mm3 breaks compile of drivers/char/esp.c
Date: Sat, 12 Mar 2005 18:39:35 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503121839.36970.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/esp.c: In function 'rs_stop':
drivers/char/esp.c:213: error: 'struct esp_struct' has no member named 'lock'
drivers/char/esp.c:219: error: 'struct esp_struct' has no member named 'lock'
drivers/char/esp.c: In function 'rs_start':
drivers/char/esp.c:230: error: 'struct esp_struct' has no member named 'lock'
drivers/char/esp.c:236: error: 'struct esp_struct' has no member named 'lock'
[...]

Obvious "fix" is to revert the changes to esp.c code.
