Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbUL0PUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUL0PUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUL0PUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:20:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40091 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261899AbUL0PUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:20:19 -0500
Subject: PATCH: kmalloc packet slab
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104156983.20944.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 27 Dec 2004 14:16:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The networking world runs in 1514 byte packets pretty much all the time.
This adds a 1620 byte slab for such objects and is one of the internally
generated Red Hat patches we use on things like Fedora Core 3. Original:
Arjan van de Ven.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.10/include/linux/kmalloc_sizes.h linux-2.6.10/include/linux/kmalloc_sizes.h
--- linux.vanilla-2.6.10/include/linux/kmalloc_sizes.h	2004-12-25 21:13:57.000000000 +0000
+++ linux-2.6.10/include/linux/kmalloc_sizes.h	2004-12-26 17:05:55.015102744 +0000
@@ -12,6 +12,7 @@
 	CACHE(256)
 	CACHE(512)
 	CACHE(1024)
+	CACHE(1620)
 	CACHE(2048)
 	CACHE(4096)
 	CACHE(8192)

