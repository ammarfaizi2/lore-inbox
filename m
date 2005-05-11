Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVEKIpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVEKIpL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 04:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVEKIpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 04:45:11 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:45523 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S261927AbVEKIpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 04:45:05 -0400
Date: Wed, 11 May 2005 10:32:54 +0200
To: Greg KH <gregkh@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, James Chapman <jchapman@katalix.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH] ds1337: export ds1337_do_command
Message-ID: <20050511083254.GA12146@orphique>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org> <20050510121814.GB2492@orphique> <20050510175549.GC1530@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510175549.GC1530@suse.de>
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 10:55:49AM -0700, Greg KH wrote:
> > --- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.637992600 +0200
> > +++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 14:13:05.064404656 +0200
> > @@ -380,5 +380,7 @@
> >  MODULE_DESCRIPTION("DS1337 RTC driver");
> >  MODULE_LICENSE("GPL");
> >  
> > +EXPORT_SYMBOL(ds1337_do_command);
> 
> EXPORT_SYMBOL_GPL() ok?

Export ds1337_do_command so it could be used also if driver is built as
module.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.000000000 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-11 10:28:13.152690512 +0200
@@ -380,5 +380,7 @@
 MODULE_DESCRIPTION("DS1337 RTC driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL_GPL(ds1337_do_command);
+
 module_init(ds1337_init);
 module_exit(ds1337_exit);
