Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVLJRrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVLJRrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVLJRrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 12:47:21 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:50576 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964942AbVLJRrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 12:47:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [patch 1/2] Add platform_device_del()
Date: Sat, 10 Dec 2005 12:47:18 -0500
User-Agent: KMail/1.9
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <20051210063626.817047000.dtor_core@ameritech.net> <20051210064750.775640000.dtor_core@ameritech.net> <20051210175816.6ce682df.khali@linux-fr.org>
In-Reply-To: <20051210175816.6ce682df.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512101247.18892.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Saturday 10 December 2005 11:58, Jean Delvare wrote:
> Hi Dmirty,
> 
> > Driver core: add platform_device_del function
> > 
> > Having platform_device_del90 allows more straightforward error
> > handling code in drivers registering platform devices.
> > (...)
> > +/**
> > + *	platform_device_unregister - unregister a platform-level device
> > + *	@pdev:	platform device we're unregistering
> > + *
> > + *	Unregistration is done in 2 steps. Fisrt we release all resources
> > + *	and remove it from the sybsystem, then we drop reference count by
> 
> Typo: subsystem.

Will fix, thank you for noticing.

> 
> > + *	calling platform_device_put().
> > + */
> 
> Other than that, and let alone the fact that I prefer code cleanups as
> separate patches, and the fact that I don't think moving
> platform_device_register() around adds much value, this patch looks
> good to me.
>

It was not moved ;) platform_device_register() is and was in front of
platform_device_unregister. But because the new platform_device_del()
reused most of the platform_device_unregister() body patch plays a trick
on you making you believe that some code was moved around.

-- 
Dmitry
