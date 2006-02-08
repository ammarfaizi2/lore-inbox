Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWBHGpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWBHGpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWBHGns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34690 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161012AbWBHGnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:43:23 -0500
Message-Id: <20060208064900.840808000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Zinx Verituse <zinx@bluecherry.net>, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: [PATCH 09/23] Input: sidewinder - fix an oops
Content-Disposition: inline; filename=input-sidewinder-fix-an-oops.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Dynalloc conversion strikes again...

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/input/joystick/sidewinder.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.15.3/drivers/input/joystick/sidewinder.c
===================================================================
--- linux-2.6.15.3.orig/drivers/input/joystick/sidewinder.c
+++ linux-2.6.15.3/drivers/input/joystick/sidewinder.c
@@ -736,7 +736,7 @@ static int sw_connect(struct gameport *g
 		sprintf(sw->name, "Microsoft SideWinder %s", sw_name[sw->type]);
 		sprintf(sw->phys[i], "%s/input%d", gameport->phys, i);
 
-		input_dev = input_allocate_device();
+		sw->dev[i] = input_dev = input_allocate_device();
 		if (!input_dev) {
 			err = -ENOMEM;
 			goto fail3;

--
