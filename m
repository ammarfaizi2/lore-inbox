Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUELJzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUELJzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 05:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUELJzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 05:55:33 -0400
Received: from gruby.cs.net.pl ([62.233.142.99]:10763 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S264937AbUELJz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 05:55:28 -0400
Date: Wed, 12 May 2004 11:55:27 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] missing include in drivers/sound/kahlua.c
Message-ID: <20040512095527.GD17109@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/sound/kahlua: include <asm/delay.h> for udelay()
(on some archs this header is not included from other ones used by this
driver)

--- linux-2.4.26/drivers/sound/kahlua.c.orig	Fri Jun 13 16:51:36 2003
+++ linux-2.4.26/drivers/sound/kahlua.c	Tue May 11 12:02:44 2004
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <asm/delay.h>
 
 #include "sound_config.h"
 

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
