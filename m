Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbUBXLgc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbUBXLgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:36:31 -0500
Received: from linux-bt.org ([217.160.111.169]:18836 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262233AbUBXLek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:34:40 -0500
Subject: Re: [PATCH 7/9] tda1004x DVB frontend update
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Hunold <hunold@convergence.de>
Cc: Andrew Morton <akpm@osdl.org>, Michael Hunold <hunold@linuxtv.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <403A841E.9090700@convergence.de>
References: <10775702831806@convergence.de>	<10775702843054@convergence.de>
	 <20040223140943.7e58eb5c.akpm@osdl.org>  <403A841E.9090700@convergence.de>
Content-Type: text/plain
Message-Id: <1077622455.2880.33.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 12:34:15 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> > was there some plan to convert DVB over to using the firmware loader?
> 
> Yes. But as I wrote in the mail to Christoph, we currently don't have a 
> chance to use some in-kernel structure (pci device, i2c bus) that 
> automatically exports the firmware loading magic through sysfs.
> 
> Because of this, we would have to write our own sysfs backend for the 
> dvb i2c subsystem, in order to get proper firmware loading support.

I don't know if this is the right way, but the atmel_cs driver uses this
workaround to make use of the firmware loader.

	/* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
	static struct device atmel_device = {
	        .bus_id    = "pcmcia",
	};

Regards

Marcel


