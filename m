Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTIPSDz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 14:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTIPSDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 14:03:55 -0400
Received: from web40514.mail.yahoo.com ([66.218.78.131]:31572 "HELO
	web40514.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262454AbTIPSDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 14:03:53 -0400
Message-ID: <20030916180352.40838.qmail@web40514.mail.yahoo.com>
Date: Tue, 16 Sep 2003 11:03:52 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Compile error building alsa-driver-0.9.6 with linux-2.4.23pre4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While building, I get the following error:

gcc -D__KERNEL__ -DMODULE=1 -I/update/alsa-driver-0.9.6/include  -I/usr/src/linux/include -O2
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4 -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  
-DEXPORT_SYMTAB -c hwdep.c
In file included from /update/alsa-driver-0.9.6/include/sound/driver.h:42,
                 from hwdep.c:22:
/update/alsa-driver-0.9.6/include/adriver.h:200: redefinition of `irqreturn_t'
/usr/src/linux/include/linux/interrupt.h:16: `irqreturn_t' previously declared here.

To get it to build, I commented out the line

 typedef void irqreturn_t;

in alsa-driver-0.9.6/include/adriver.h.

-Alex

=====
I code, therefore I am

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
