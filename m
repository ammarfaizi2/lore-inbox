Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130175AbQJaEVb>; Mon, 30 Oct 2000 23:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbQJaEVV>; Mon, 30 Oct 2000 23:21:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37761 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130210AbQJaEVI>;
	Mon, 30 Oct 2000 23:21:08 -0500
Date: Mon, 30 Oct 2000 20:06:59 -0800
Message-Id: <200010310406.UAA05413@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: decklin@red-bean.com
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20001030222644.A9869@gyah.this.is.broken> (message from Decklin
	Foster on Mon, 30 Oct 2000 22:26:44 -0500)
Subject: Re: test10-pre7 compile error in ip_forward.c
In-Reply-To: <20001030222644.A9869@gyah.this.is.broken>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry.  Please try this patch below.  Linus, please apply:

--- include/linux/netdevice.h.~1~	Mon Oct 30 17:57:20 2000
+++ include/linux/netdevice.h	Mon Oct 30 20:05:38 2000
@@ -55,6 +55,7 @@
 #define NET_RX_CN_MOD		2   /* Storm on its way! */
 #define NET_RX_CN_HIGH		5   /* The storm is here */
 #define NET_RX_DROP		-1  /* packet dropped */
+#define NET_RX_BAD		-2  /* packet dropped due to kernel error */
 
 #define net_xmit_errno(e)	((e) != NET_XMIT_CN ? -ENOBUFS : 0)
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
