Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVAYNI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVAYNI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVAYNI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:08:26 -0500
Received: from smtp.nextra.cz ([195.70.130.4]:60426 "EHLO smtp.nextra.cz")
	by vger.kernel.org with ESMTP id S261929AbVAYNIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:08:15 -0500
Message-ID: <41F64495.1000303@nextra.cz>
Date: Tue, 25 Jan 2005 14:07:33 +0100
From: Zdenek Pavlas <pavlas@nextra.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: initramfs: move inode hash table to __initdata
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to waste 128B of kmem.

--- linux-2.6.10/init/initramfs.c.orig
+++ linux-2.6.10/init/initramfs.c
@@ -25,9 +25,9 @@
  }

  /* link hash */

-static struct hash {
+static __initdata struct hash {
         int ino, minor, major;
         struct hash *next;
         char *name;
  } *head[32];

-- 
Zdenek Pavlas
