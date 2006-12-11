Return-Path: <linux-kernel-owner+w=401wt.eu-S1763020AbWLKTGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763020AbWLKTGL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763010AbWLKTGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:06:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4059 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937547AbWLKTGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:06:09 -0500
Date: Mon, 11 Dec 2006 20:06:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Hans J. Koch" <hjk@linutronix.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benedikt Spranger <b.spranger@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/uio/: make 3 functions static
Message-ID: <20061211190619.GE28443@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
> +gregkh-driver-uio.patch
> +gregkh-driver-uio-dummy.patch
>...
>  driver tree updates
>...

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/uio/uio.c       |    2 +-
 drivers/uio/uio_dummy.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-mm1/drivers/uio/uio.c.old	2006-12-11 18:26:58.000000000 +0100
+++ linux-2.6.19-mm1/drivers/uio/uio.c	2006-12-11 18:27:14.000000000 +0100
@@ -602,7 +602,7 @@
 	return 0;
 }
 
-void __exit uio_exit(void)
+static void __exit uio_exit(void)
 {
 }
 
--- linux-2.6.19-mm1/drivers/uio/uio_dummy.c.old	2006-12-11 18:27:43.000000000 +0100
+++ linux-2.6.19-mm1/drivers/uio/uio_dummy.c	2006-12-11 18:28:15.000000000 +0100
@@ -137,7 +137,7 @@
 
 }
 
-struct platform_device *uio_dummy_device;
+static struct platform_device *uio_dummy_device;
 
 static struct device_driver uio_dummy_driver = {
 	.name		= "uio_dummy",
@@ -160,7 +160,7 @@
 	return driver_register(&uio_dummy_driver);
 }
 
-void __exit uio_dummy_exit(void)
+static void __exit uio_dummy_exit(void)
 {
 	platform_device_unregister(uio_dummy_device);
 	driver_unregister(&uio_dummy_driver);

