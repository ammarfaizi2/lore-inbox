Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270169AbTGPHRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 03:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270158AbTGPHRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 03:17:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:50409 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270169AbTGPHR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 03:17:28 -0400
Date: Wed, 16 Jul 2003 00:31:35 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030716073135.GA5338@kroah.com>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716062922.GA1000@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 04:29:22PM +1000, CaT wrote:
> On Tue, Jul 15, 2003 at 11:10:09PM -0700, Greg KH wrote:
> > On Wed, Jul 16, 2003 at 04:04:43PM +1000, CaT wrote:
> > > On Tue, Jul 15, 2003 at 09:11:27AM -0700, Greg KH wrote:
> > > Did I do the right thing?
> > 
> > Looks good, but are you _really_ building all of those drivers into your
> > kernel?  Make them modules, that way booting will not require a small
> 
> No. Just i2c-dev, i2c-core, i2c-sensor, i2c-piix4 and adm1021. Sorry
> for not weeding out the useless stuff above. I was still waking up. :)
> 
> > nap :)
> 
> :)
> 
> > Then load only the i2c bus driver that you have.  See if that causes the
> > system to slow down, or cause any kernel log messages?
> 
> i2c alone does not.
> 
> > Only then try loading a i2c client driver, for your hardware.
> 
> I can go through this again. Do you want me to insert any further
> debugging stuff?
> 
> > Exactly what i2c hardware do you have anyway?
> 
> PIIX4 and ADM1021.
> 
> .config has the following:
> 
> CONFIG_SENSORS_ADM1021=y
> CONFIG_I2C=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_SENSOR=y

Please change them to =m so that it's easier to try to debug this.

Then just load the i2c_piix4 module.  If things still work just fine,
then try the i2c-adm1021 driver.  See what the kernel log says then.

thanks,

greg k-h
