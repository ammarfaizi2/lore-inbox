Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTDWOm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbTDWOm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:42:59 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.27]:11920 "EHLO
	mwinf0401.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264057AbTDWOmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:42:55 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB speedtouch: compile fix
Date: Wed, 23 Apr 2003 16:54:55 +0200
User-Agent: KMail/1.5.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/kqp+lMFinIj1QB"
Message-Id: <200304231654.55881.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_/kqp+lMFinIj1QB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The rx_inuse field no longer exists.

 speedtch.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 23 16:51:29 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 23 16:51:29 2003
@@ -579,8 +579,7 @@
 						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
 					} else {
 						dbg
-						    ("dropping incoming packet : rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
-						     atomic_read (&atmsar_vcc->vcc->rx_inuse),
+						    ("dropping incoming packet : vcc->sk->rcvbuf = %d, skb->true_size = %d",
 						     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
 						dev_kfree_skb (new);
 					}


--Boundary-00=_/kqp+lMFinIj1QB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="compile-2.4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="compile-2.4.diff"

 speedtouch.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/usb/speedtouch.c b/drivers/usb/speedtouch.c
--- a/drivers/usb/speedtouch.c	Wed Apr 23 16:50:12 2003
+++ b/drivers/usb/speedtouch.c	Wed Apr 23 16:50:12 2003
@@ -579,8 +579,7 @@
 						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
 					} else {
 						dbg
-						    ("dropping incoming packet : rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
-						     atomic_read (&atmsar_vcc->vcc->rx_inuse),
+						    ("dropping incoming packet : vcc->sk->rcvbuf = %d, skb->true_size = %d",
 						     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
 						dev_kfree_skb (new);
 					}


--Boundary-00=_/kqp+lMFinIj1QB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="compile-2.5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="compile-2.5.diff"

 speedtch.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed Apr 23 16:51:29 2003
+++ b/drivers/usb/misc/speedtch.c	Wed Apr 23 16:51:29 2003
@@ -579,8 +579,7 @@
 						atmsar_vcc->vcc->push (atmsar_vcc->vcc, new);
 					} else {
 						dbg
-						    ("dropping incoming packet : rx_inuse = %d, vcc->sk->rcvbuf = %d, skb->true_size = %d",
-						     atomic_read (&atmsar_vcc->vcc->rx_inuse),
+						    ("dropping incoming packet : vcc->sk->rcvbuf = %d, skb->true_size = %d",
 						     atmsar_vcc->vcc->sk->rcvbuf, new->truesize);
 						dev_kfree_skb (new);
 					}


--Boundary-00=_/kqp+lMFinIj1QB--
