Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTDXXf4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264491AbTDXXfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:35:51 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12482 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264482AbTDXXeG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:34:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1051228052617@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.68
In-Reply-To: <10512280522043@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 24 Apr 2003 16:47:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1165.2.7, 2003/04/23 12:07:03-07:00, baldrick@wanadoo.fr

[PATCH] USB speedtouch: compile fix

The rx_inuse field no longer exists.


 drivers/usb/misc/speedtch.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Thu Apr 24 16:25:26 2003
+++ b/drivers/usb/misc/speedtch.c	Thu Apr 24 16:25:26 2003
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

