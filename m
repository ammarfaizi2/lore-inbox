Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292142AbSBTSQA>; Wed, 20 Feb 2002 13:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292146AbSBTSPk>; Wed, 20 Feb 2002 13:15:40 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:30731 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292142AbSBTSPf>;
	Wed, 20 Feb 2002 13:15:35 -0500
Date: Wed, 20 Feb 2002 10:10:21 -0800
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] usb vicam driver fix for 2.5.5
Message-ID: <20020220181021.GA30724@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 23 Jan 2002 16:08:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's a small patch for 2.5.5 that enables the USB vicam driver to build
properly again.

thanks,

greg k-h


diff -Nru a/drivers/usb/vicam.c b/drivers/usb/vicam.c
--- a/drivers/usb/vicam.c	Wed Feb 20 10:10:15 2002
+++ b/drivers/usb/vicam.c	Wed Feb 20 10:10:15 2002
@@ -40,6 +40,8 @@
 #include <linux/errno.h>
 #include <linux/poll.h>
 #include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/fcntl.h>
 #include <linux/module.h>
