Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUJTSnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUJTSnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268894AbUJTSc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:32:27 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:53146 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268950AbUJTSWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:22:23 -0400
Date: Wed, 20 Oct 2004 11:22:22 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove inclusion of <linux/irq.h> from pci/quirks.c
Message-ID: <20041020182222.GA20201@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<linux/irq.h> states:

/*
 * Please do not include this file in generic code.  There is currently
 * no requirement for any architecture to implement anything held
 * within this file.
 *
 * Thanks. --rmk
 */

The latest update into pci/quirks.c did not follow this and breaks 
building on ARM.

Signed-off-by: Deepak Saxena <dsaxena@plexity.met>

===== drivers/pci/quirks.c 1.51 vs edited =====
--- 1.51/drivers/pci/quirks.c	2004-10-18 22:26:45 -07:00
+++ edited/drivers/pci/quirks.c	2004-10-20 11:15:14 -07:00
@@ -18,7 +18,6 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 
 #undef DEBUG
 
-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
