Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130161AbRBZFbY>; Mon, 26 Feb 2001 00:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130160AbRBZFbT>; Mon, 26 Feb 2001 00:31:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40856 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130155AbRBZFa2>;
	Mon, 26 Feb 2001 00:30:28 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15001.59702.218278.26899@pizda.ninka.net>
Date: Sun, 25 Feb 2001 21:27:18 -0800 (PST)
To: "Vibol Hou" <vhou@khmer.cc>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: RE: UDP attack? How to suppress kernel msgs?
In-Reply-To: <NDBBKKONDOBLNCIOPCGHGEMBEOAA.vhou@khmer.cc>
In-Reply-To: <NDBBKKONDOBLNCIOPCGHIEMAEOAA.vhou@khmer.cc>
	<NDBBKKONDOBLNCIOPCGHGEMBEOAA.vhou@khmer.cc>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix your problem:

--- include/net/sock.h.~1~	Thu Feb 22 21:12:12 2001
+++ include/net/sock.h	Sun Feb 25 21:26:16 2001
@@ -1279,7 +1279,7 @@
  *	Enable debug/info messages 
  */
 
-#if 0
+#if 1
 #define NETDEBUG(x)	do { } while (0)
 #else
 #define NETDEBUG(x)	do { x; } while (0)
