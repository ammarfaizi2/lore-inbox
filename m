Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315048AbSDWDwA>; Mon, 22 Apr 2002 23:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315050AbSDWDv7>; Mon, 22 Apr 2002 23:51:59 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:52493 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S315048AbSDWDv6>;
	Mon, 22 Apr 2002 23:51:58 -0400
Date: Mon, 22 Apr 2002 22:42:53 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: 2.5.9 compile warnings/errors
Message-ID: <Pine.LNX.4.33.0204222235050.15600-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
 While 'make bzImage', I received the following set of errors (I didn't 
see them posted on l-k yet. If I missed them, sorry in advance.) 

Regards,
Frank

ppp_generic.c: In function `ppp_read':
ppp_generic.c:381: warning: `ret' might be used uninitialized in this function
[a possible solution below]

--- drivers/net/ppp_generic.c.old	Mon Apr 15 20:58:16 2002
+++ drivers/net/ppp_generic.c	Mon Apr 22 22:01:32 2002
@@ -381,6 +381,8 @@
 	ssize_t ret;
 	struct sk_buff *skb = 0;
 
+	ret = count;
+
 	if (pf == 0)
 		return -ENXIO;
 	add_wait_queue(&pf->rwait, &wait);


[a few files had the same warning in the below directory]
resources.c: In function `unlink_vcc':
resources.c:199: warning: passing arg 2 of `constant_test_bit' from incompatible pointer type
resources.c:199: warning: passing arg 2 of `variable_test_bit' from incompatible pointer type
clip.c:732: warning: passing arg 2 of `set_bit' from incompatible pointer type
clip.c:733: warning: passing arg 2 of `set_bit' from incompatible pointer type
make[3]: Leaving directory `/usr/src/linux/net/atm'

dev.c: In function `netif_receive_skb':
dev.c:1465: void value not ignored as it ought to be
make[3]: *** [dev.o] Error 1
make[3]: Leaving directory `/usr/src/linux/net/core'
make[2]: *** [first_rule] Error 2

