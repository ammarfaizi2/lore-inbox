Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTLKHIw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTLKHIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:08:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:710 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264374AbTLKHIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:08:35 -0500
Date: Wed, 10 Dec 2003 22:44:41 -0800
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031211064441.GA2529@kroah.com>
References: <20031210165540.B26394@fi.muni.cz> <20031210212807.GA8784@kroah.com> <1071105744.1154.1.camel@chevrolet.hybel> <1071114290.750.18.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071114290.750.18.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 04:44:50AM +0100, Stian Jordet wrote:
> tor, 11.12.2003 kl. 02.22 skrev Stian Jordet:
> > ons, 10.12.2003 kl. 22.28 skrev Greg KH:
> > > Can you try the patch below?  I think it will fix the problem.
> > 
> > Fixes it for me. Thanks :)
> > 
> Uhm.. I was a bit too fast. It fixed the problem, okay, but it makes the
> kernel spit out a lot of these messages:
> 
> 
> Dec 11 02:29:40 chevrolet kernel: usb 1-1: USB disconnect, address 7
> Dec 11 02:29:40 chevrolet kernel: hub 1-0:1.0: new USB device on port 1,
> assigned address 8

This has nothing to do with the visor or other usb-serial drivers.  It
looks like you have either a flaky USB connection, or a power issue on
your USB hub.  Either way, the device keeps disconnecting itself
electronically (nothing Linux can do about that) and then reconnecting
itself.  Not good.

Is this connected to a powered hub?  If not, I'd recommend using one, or
getting a new keyboard/mouse as this is on the fritz.

thanks,

greg k-h
