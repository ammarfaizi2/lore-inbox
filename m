Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUE2XeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUE2XeS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 19:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUE2XeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 19:34:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:940 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261210AbUE2XeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 19:34:17 -0400
Subject: Re: [PATCH] use new msleep() in ADT746x driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <40B8EA88.6030607@pobox.com>
References: <200405291908.i4TJ8Acm011281@hera.kernel.org>
	 <40B8EA88.6030607@pobox.com>
Content-Type: text/plain
Message-Id: <1085873203.2140.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 30 May 2004 09:26:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-30 at 05:54, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> > diff -Nru a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
> > --- a/drivers/macintosh/therm_adt746x.c	2004-05-29 12:08:19 -07:00
> > +++ b/drivers/macintosh/therm_adt746x.c	2004-05-29 12:08:19 -07:00
> > @@ -246,8 +246,7 @@
> >  
> >  	while(monitor_running)
> >  	{
> > -		set_task_state(current, TASK_UNINTERRUPTIBLE);
> > -		schedule_timeout(2*HZ);
> > +		msleep(2000);
> 
> 
> IMO this is moving the code away from what the coder appeared to intend.
> 
> A "sleep(2)" would be preferred, and more clear.

This patch was done by the original author of the driver

Ben.


