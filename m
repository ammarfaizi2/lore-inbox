Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUC1MQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 07:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUC1MQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 07:16:03 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:62217 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261430AbUC1MQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 07:16:00 -0500
Date: Sun, 28 Mar 2004 14:15:52 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, mdharm-usb@one-eyed-alien.net
Subject: [PATCH-2.4.26] sddr09 cleanup
Message-ID: <20040328121552.GD24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

sddr09 prints a warning about print_heap() which is not used.
I ifdef'ed it out so that is still is usable for debugging
purposes.

Please apply following patch to 2.4.26-rc1.
Willy


--- ./drivers/usb/storage/sddr09.c.orig	Sun Mar 28 14:03:46 2004
+++ ./drivers/usb/storage/sddr09.c	Sun Mar 28 14:04:31 2004
@@ -437,7 +437,6 @@
 
 	return result;
 }
-#endif
 
 /*
  * Request Sense Command: 12 bytes.
@@ -465,6 +464,7 @@
 
 	return result;
 }
+#endif
 
 /*
  * Read Command: 12 bytes.
