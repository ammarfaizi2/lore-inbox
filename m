Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTKKRu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTKKRu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:50:28 -0500
Received: from smtp.terra.es ([213.4.129.129]:24284 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S263638AbTKKRu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:50:27 -0500
Date: Tue, 11 Nov 2003 18:49:19 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-Id: <20031111184919.43a93a88.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.44.0311102136280.2881-100000@home.osdl.org>
References: <boppm8$94h$1@gatekeeper.tmr.com>
	<Pine.LNX.4.44.0311102136280.2881-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 10 Nov 2003 21:40:58 -0800 (PST) Linus Torvalds <torvalds@osdl.org>
escribió:

> Now it's your turn. Instead of wasting my time complaining, how about you
> put up or shut up? Show me the code. THEN post it. Until you do, there's 
> no point to your mails.

Until then, I'd suggest this patch to avoid more complains about this:

diff -puN drivers/ide/Kconfig~idescsi-broken drivers/ide/Kconfig
--- tim/drivers/ide/Kconfig~idescsi-broken	2003-11-11 18:35:23.000000000 +0100
+++ tim-diego/drivers/ide/Kconfig	2003-11-11 18:36:07.000000000 +0100
@@ -247,7 +247,7 @@ config BLK_DEV_IDEFLOPPY
 
 config BLK_DEV_IDESCSI
 	tristate "SCSI emulation support"
-	depends on SCSI
+	depends on SCSI && BROKEN
 	---help---
 	  This will provide SCSI host adapter emulation for IDE ATAPI
devices, 	  and will allow you to use a SCSI device driver instead of
a native

_

