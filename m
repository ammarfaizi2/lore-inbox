Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUFJN4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUFJN4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 09:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUFJN4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 09:56:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16138 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261321AbUFJN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 09:56:39 -0400
Date: Thu, 10 Jun 2004 14:56:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Add platform_device_register_simple
Message-ID: <20040610145634.B965@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <200406090221.24739.dtor_core@ameritech.net> <200406100143.53381.dtor_core@ameritech.net> <20040610111623.D20006@flint.arm.linux.org.uk> <200406100755.59943.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200406100755.59943.dtor_core@ameritech.net>; from dtor_core@ameritech.net on Thu, Jun 10, 2004 at 07:55:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 07:55:59AM -0500, Dmitry Torokhov wrote:
> On Thursday 10 June 2004 05:16 am, Russell King wrote:
> > 
> > As this currently stands, you have no chance to add resources to the
> > platform device before it's made available to the driver.  It's likely
> > that any attached resources will have the same lifetime as the
> > device itself, so it makes sense to allocate them together with the
> > platform device.
> > 
> 
> Are you suggesting adding pointer to resources as a 3rd argument and
> automotically release it for the user? It probably could be done but users
> will be tempted to use static module data and bad things would happen.

Please read my second sentence again.  It implies a copy of the resources
is kept with the platform device, so both have the same lifetime.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
