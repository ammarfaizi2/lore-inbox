Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVDRQrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVDRQrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVDRQrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 12:47:11 -0400
Received: from post.hexten.net ([65.254.52.58]:2236 "EHLO post.hexten.net")
	by vger.kernel.org with ESMTP id S262129AbVDRQpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 12:45:04 -0400
In-Reply-To: <37b978ceccdb5fbea39a925ea9eaa2cb@hexten.net>
References: <37b978ceccdb5fbea39a925ea9eaa2cb@hexten.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4c7663456024e2e92f003a136a74b39b@hexten.net>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Andy Armstrong <andy@hexten.net>
Subject: [PATCH 2.6.11.7 2/2] USB HID: Patch for Cherry CyMotion Linux keyboard
Date: Mon, 18 Apr 2005 17:45:00 +0100
To: Andy Armstrong <andy@hexten.net>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here are the changes to support the extra keys...

diff -ur linux-2.6.11.7.orig/drivers/usb/input/hid-input.c 
linux/drivers/usb/input/hid-input.c
--- linux-2.6.11.7.orig/drivers/usb/input/hid-input.c	2005-04-07 
19:57:34.000000000 +0100
+++ linux/drivers/usb/input/hid-input.c	2005-04-18 13:36:16.000000000 
+0100
@@ -270,6 +270,12 @@
  				case 0x227: map_key_clear(KEY_REFRESH);		break;
  				case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
  				case 0x238: map_rel(REL_HWHEEL);		break;
+                                case 0x233: 
map_key_clear(KEY_SCROLLUP);        break;
+                                case 0x234: 
map_key_clear(KEY_SCROLLDOWN);      break;
+                                case 0x301: map_key_clear(KEY_PROG1);  
          break;
+                                case 0x302: map_key_clear(KEY_PROG2);  
          break;
+                                case 0x303: map_key_clear(KEY_PROG3);  
          break;
+                                case 0x279: map_key_clear(KEY_AGAIN);  
          break;
  				default:    goto unknown;
  			}
  			break;

-- 
Andy Armstrong, hexten.net

