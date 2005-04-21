Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVDUHiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVDUHiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVDUHiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:38:23 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:39351 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261438AbVDUHaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 2/22] W1: formatting fixes
Date: Thu, 21 Apr 2005 02:08:43 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210208.44541.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

w1: some formatting changes to bring the code in line with
    CodingStyle guidelines.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 dscore.c |    4 +---
 w1.c     |   21 +++++++++------------
 2 files changed, 10 insertions(+), 15 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -513,8 +513,7 @@ void w1_slave_found(unsigned long data, 
 		    sl->reg_num.crc == tmp->crc) {
 			set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 			break;
-		}
-		else if (sl->reg_num.family == tmp->family) {
+		} else if (sl->reg_num.family == tmp->family) {
 			family_found = 1;
 			break;
 		}
@@ -522,10 +521,10 @@ void w1_slave_found(unsigned long data, 
 		slave_count++;
 	}
 
-		if (slave_count == dev->slave_count && rn ) {
-			tmp = cpu_to_le64(rn);
-			if(((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&tmp, 7))
-				w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
+	if (slave_count == dev->slave_count && rn) {
+		tmp = cpu_to_le64(rn);
+		if (((rn >> 56) & 0xff) == w1_calc_crc8((u8 *)&tmp, 7))
+			w1_attach_slave_device(dev, (struct w1_reg_num *) &rn);
 	}
 
 	atomic_dec(&dev->refcnt);
@@ -544,8 +543,8 @@ void w1_search(struct w1_master *dev)
 
 	desc_bit = 64;
 
-	while (!(id_bit && comp_bit) && !last_device
-		&& count++ < dev->max_slave_count) {
+	while (!(id_bit && comp_bit) && !last_device &&
+	       count++ < dev->max_slave_count) {
 		last = rn;
 		rn = 0;
 
@@ -590,8 +589,7 @@ void w1_search(struct w1_master *dev)
 						last_family_desc = last_zero;
 				}
 
-			}
-			else
+			} else
 				search_bit = id_bit;
 
 			tmp = search_bit;
@@ -760,8 +758,7 @@ int w1_process(void *data)
 				kfree (sl);
 
 				dev->slave_count--;
-			}
-			else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
+			} else if (test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
 				sl->ttl = dev->slave_ttl;
 		}
 		up(&dev->mutex);
Index: dtor/drivers/w1/dscore.c
===================================================================
--- dtor.orig/drivers/w1/dscore.c
+++ dtor/drivers/w1/dscore.c
@@ -319,10 +319,8 @@ int ds_wait_status(struct ds_device *dev
 	if (((err > 16) && (buf[0x10] & 0x01)) || count >= 100 || err < 0) {
 		ds_recv_status(dev, st);
 		return -1;
-	}
-	else {
+	} else
 		return 0;
-	}
 }
 
 int ds_reset(struct ds_device *dev, struct ds_status *st)
