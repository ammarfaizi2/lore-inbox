Return-Path: <linux-kernel-owner+w=401wt.eu-S1753708AbWLPN44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbWLPN44 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 08:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbWLPN44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 08:56:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3331 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753708AbWLPN4z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 08:56:55 -0500
Date: Sat, 16 Dec 2006 14:56:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Hans J. Koch" <hjk@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benedikt Spranger <b.spranger@linutronix.de>
Subject: [-mm patch] make uio_irq_handler() static
Message-ID: <20061216135654.GB3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214225913.3338f677.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 10:59:13PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-mm1:
>...
> +gregkh-driver-uio-irq.patch
> 
>  driver tree updates
>...

This patch makes the needlessly global uio_irq_handler() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.20-rc1-mm1/drivers/uio/uio_irq.c.old	2006-12-15 22:23:23.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/uio/uio_irq.c	2006-12-15 22:33:40.000000000 +0100
@@ -22,7 +22,7 @@
 
 static struct uio_device *uio_irq_idev;
 
-irqreturn_t uio_irq_handler(int irq, void *dev_id)
+static irqreturn_t uio_irq_handler(int irq, void *dev_id)
 {
 	return IRQ_HANDLED;
 }

