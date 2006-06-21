Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWFUFbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWFUFbX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 01:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWFUFbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 01:31:23 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:9063 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751085AbWFUFbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 01:31:22 -0400
Message-ID: <4498D9F6.6020700@oracle.com>
Date: Tue, 20 Jun 2006 22:32:38 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: dtor_core@ameritech.net, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [Ubuntu PATCH] input: allow root to inject unknown scan codes
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow root to inject unknown scan codes for input device.

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=250bc863956a93a8eab7991b0dc7f040eb5d25cc


---
 drivers/input/input.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2617-pv.orig/drivers/input/input.c
+++ linux-2617-pv/drivers/input/input.c
@@ -75,7 +75,7 @@ void input_event(struct input_dev *dev, 
 
 		case EV_KEY:
 
-			if (code > KEY_MAX || !test_bit(code, dev->keybit) || !!test_bit(code, dev->key) == value)
+			if (code > KEY_MAX || !!test_bit(code, dev->key) == value)
 				return;
 
 			if (value == 2)



