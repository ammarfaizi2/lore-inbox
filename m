Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTDUHrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 03:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbTDUHrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 03:47:37 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:40695 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP id S263782AbTDUHrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 03:47:37 -0400
Message-ID: <3EA3A558.6010905@csse.uwa.edu.au>
Date: Mon, 21 Apr 2003 16:01:28 +0800
From: David Glance <david@csse.uwa.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: PATCH: usb-uhci: interrupt out with urb->interval 0 (corrected)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against 2.4.21-pre7

--- /usr/src/linux.orig/drivers/usb/host/usb-uhci.c  2003-04-21 
15:53:19.000000000 +0800
+++ /usr/src/linux/drivers/usb/host/usb-uhci.c  2003-04-21 
15:54:40.000000000 +0800
@@ -2518,6 +2518,7 @@
                                // correct toggle after unlink
                                usb_dotoggle (urb->dev, usb_pipeendpoint 
(urb->pipe), usb_pipeout (urb->pipe));
                                clr_td_ioc(desc); // inactivate TD
+                               break;
                        }
                }
        }


