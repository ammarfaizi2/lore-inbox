Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWBHGnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWBHGnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWBHGnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:02 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15232 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161012AbWBHGmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:54 -0500
Message-Id: <20060208064902.063569000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Alexey Dobriyan <adobriyan@gmail.com>, Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH 10/23] Input: iforce - do not return ENOMEM upon successful allocation
Content-Disposition: inline; filename=input-iforce-do-not-return-enomem-upon-successful-allocation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

iforce - do not return ENOMEM upon successful allocation

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/input/joystick/iforce/iforce-main.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15.3/drivers/input/joystick/iforce/iforce-main.c
===================================================================
--- linux-2.6.15.3.orig/drivers/input/joystick/iforce/iforce-main.c
+++ linux-2.6.15.3/drivers/input/joystick/iforce/iforce-main.c
@@ -345,7 +345,7 @@ int iforce_init_device(struct iforce *if
 	int i;
 
 	input_dev = input_allocate_device();
-	if (input_dev)
+	if (!input_dev)
 		return -ENOMEM;
 
 	init_waitqueue_head(&iforce->wait);

--
