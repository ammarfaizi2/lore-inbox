Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131001AbQLNB46>; Wed, 13 Dec 2000 20:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbQLNB4o>; Wed, 13 Dec 2000 20:56:44 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:54174 "EHLO
	smtprelay2.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S131001AbQLNB4W>; Wed, 13 Dec 2000 20:56:22 -0500
Date: Wed, 13 Dec 2000 20:31:28 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
In-Reply-To: <200012132215.eBDMFas35908@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.21.0012132029260.3736-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Justin T. Gibbs wrote:

> Subject: Adaptec AIC7XXX v6.0.6 BETA Released
> -------
> After several months of testing and refinement, the Adaptec 
> sponsored aic7xxx driver is now entering Beta testing.  Although
> still missing domain validation and the last bits of cardbus
> support, there are no known issues with the driver.  I would
> encourage all users of card supported by this driver to try the
> new code and submit feedback.  Patches for late 2.2.X, 2.3.99
> and 2.4.0 are provided in the driver distribution.  For those
> of you building the driver as a module, take note that the module
> name is now "aic7xxx_mod" rather than "aic7xxx".
> 
> As always, the most recent distribution is available here:
> 
> http://people.FreeBSD.org/~gibbs/linux/

Justin,

Thanks for posting this.  Unfortunately, the kernel won't build unless you
restore this macro to the namespace after aic7xxx_linux.h blows it away:

--- linux-2.2.18/drivers/scsi/hosts.c.orig	Wed Dec 13 20:27:34 2000
+++ linux-2.2.18/drivers/scsi/hosts.c	Wed Dec 13 20:26:22 2000
@@ -137,6 +137,7 @@
 
 #ifdef CONFIG_SCSI_AIC7XXX
 #include "aic7xxx/aic7xxx_linux.h"
+#define current get_current()
 #endif
 
 #ifdef CONFIG_SCSI_IPS


Steve


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
