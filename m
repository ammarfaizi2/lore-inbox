Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWAJPOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWAJPOH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWAJPOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:14:07 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:32559 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751108AbWAJPOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:14:06 -0500
Subject: Re: [spi-devel-general] [PATCH] spi: add bus methods instead of
	driver's ones
From: dmitry pervushin <dpervushin@ru.mvista.com>
Reply-To: dpervushin@ru.mvista.com
To: David Brownell <david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200601100705.13313.david-b@pacbell.net>
References: <1136893627.4780.9.camel@diimka-laptop>
	 <200601100705.13313.david-b@pacbell.net>
Content-Type: text/plain
Organization: montavista
Date: Tue, 10 Jan 2006 18:11:51 +0300
Message-Id: <1136905911.4780.19.camel@diimka-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 07:05 -0800, David Brownell wrote:
> > @@ -125,42 +125,40 @@ struct bus_type spi_bus_type = {
> >  	.dev_attrs	= spi_dev_attrs,
> >  	.match		= spi_match_device,
> >  	.uevent		= spi_uevent,
> > +	.probe		= spi_bus_probe,
> > +	.remove		= spi_bus_remove,
> > +	.shutdown	= spi_bus_shutdown,
> >  	.suspend	= spi_suspend,
> >  	.resume		= spi_resume,
> >  };
> What kernel are you using here?  The one I'm looking at -- GIT snapshot
> as of a few minutes ago -- doesn't have probe(), remove(), or shutdown()
> methods in "struct bus_type".  I don't recall that it ever had such...
Could you please look to message from Russell King with subject "[CFT
1/29] Add bus_type probe, remove, shutdown methods." ? This patch
introduces methods named above to bus_type struct. 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
-- 
cheers, dmitry pervushin

