Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269559AbTGaQuu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274814AbTGaQuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:50:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:19924 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269559AbTGaQut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:50:49 -0400
Date: Thu, 31 Jul 2003 09:50:56 -0700
From: Greg KH <greg@kroah.com>
To: Flameeyes <daps_mls@libero.it>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2, sensors and sysfs
Message-ID: <20030731165056.GA3622@kroah.com>
References: <1059669362.23100.12.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059669362.23100.12.camel@laurelin>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 06:36:02PM +0200, Flameeyes wrote:
> Hi,
> I need to know the system temperature for check some stability problems,
> under 2.4 I was using lm_sensors patches, using i2c-viapro as i2c bus
> and via686a as chip driver (I'm using a via 686 southbridge, see the
> lspci output attached), and I was able to use sensors for see the
> temperatures.
> With the 2.6.0-test2 (and all earlier kernels since 2.5.69), I'm not
> able anymore to see the temperature, nor with sensor (or libsensor
> library) nor with sysfs (that, AFAIK, should be the new method to access
> sensors data).
> The only i2c device that I can see in the sysfs is the tuner of my
> bt-based tv card.
> I tried either with i2c-viapro and via686a as modules, and built-in in
> kernel. Nothing	changes. Also dmesg doesn't output anything.
> I have missed something?

What sensor drivers are you using in 2.4?  Are these drivers even
present in 2.6?  Remember, a lot of them have not been ported yet.

And yes, libsensors does not work right now for 2.6, you should be able
to get the sensor info yourself out of sysfs.

thanks,

greg k-h
