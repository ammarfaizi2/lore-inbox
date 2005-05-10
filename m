Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVEJR4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVEJR4C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVEJR4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:56:02 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:23712 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261724AbVEJRzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:55:52 -0400
Date: Tue, 10 May 2005 10:55:49 -0700
From: Greg KH <gregkh@suse.de>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Jean Delvare <khali@linux-fr.org>, James Chapman <jchapman@katalix.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Subject: Re: [PATCH] ds1337: export ds1337_do_command
Message-ID: <20050510175549.GC1530@suse.de>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org> <20050510121814.GB2492@orphique>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510121814.GB2492@orphique>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 02:18:14PM +0200, Ladislav Michl wrote:
> On Sun, May 08, 2005 at 10:23:51PM +0200, Jean Delvare wrote:
> > Hi James,
> > 
> > > I suggest that Ladislav's patch should still be applied and a
> > > separate patch be submitted to export the interface to modules.
> > 
> > Either way is fine with me as long as it actually happens.
> 
> Export ds1337_do_command so it could be used also if driver is built as
> module.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> --- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.637992600 +0200
> +++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 14:13:05.064404656 +0200
> @@ -380,5 +380,7 @@
>  MODULE_DESCRIPTION("DS1337 RTC driver");
>  MODULE_LICENSE("GPL");
>  
> +EXPORT_SYMBOL(ds1337_do_command);

EXPORT_SYMBOL_GPL() ok?

thanks,

greg k-h
