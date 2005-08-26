Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965083AbVHZSaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbVHZSaE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 14:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbVHZSaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 14:30:04 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6078 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S1751338AbVHZSaD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 14:30:03 -0400
Subject: Re: [patch] IBM HDAPS accelerometer driver.
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050826111821.5f0cf386.akpm@osdl.org>
References: <1125069494.18155.27.camel@betsy>
	 <20050826111821.5f0cf386.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 14:30:01 -0400
Message-Id: <1125081001.18155.73.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 11:18 -0700, Andrew Morton wrote:

> > +config SENSORS_HDAPS
> >  +	tristate "IBM Hard Drive Active Protection System (hdaps)"
> >  +	depends on HWMON
> >  +	default n
> >  +	help
> 
> How does this get along with CONFIG_INPUT=n, CONFIG_INPUT_MOUSEDEV=n, etc?

Probably a question you should of asked before merging the patch.  ;-)

We just need CONFIG_INPUT.

Thanks,

	Robert Love


Depend on CONFIG_INPUT.

Signed-off-by: Robert Love <rml@novell.com>

diff -u linux/drivers/hwmon/Kconfig linux/drivers/hwmon/Kconfig
--- linux/drivers/hwmon/Kconfig	2005-08-26 11:07:53.000000000 -0400
+++ linux/drivers/hwmon/Kconfig	2005-08-26 14:28:09.000000000 -0400
@@ -413,7 +413,7 @@
 
 config SENSORS_HDAPS
 	tristate "IBM Hard Drive Active Protection System (hdaps)"
-	depends on HWMON
+	depends on HWMON && INPUT
 	default n
 	help
 	  This driver provides support for the IBM Hard Drive Active Protection


