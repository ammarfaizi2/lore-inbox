Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271176AbTGPWmv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271178AbTGPWmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:42:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:21888 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271176AbTGPWme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:42:34 -0400
Date: Wed, 16 Jul 2003 15:54:52 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030716225452.GA3419@kroah.com>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com> <20030716224718.GA4612@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716224718.GA4612@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 08:47:18AM +1000, CaT wrote:
> On Wed, Jul 16, 2003 at 12:31:35AM -0700, Greg KH wrote:
> > Please change them to =m so that it's easier to try to debug this.
> 
> Done.
> 
> > Then just load the i2c_piix4 module.  If things still work just fine,
> > then try the i2c-adm1021 driver.  See what the kernel log says then.
> 
> All went well till the last step of loading the adm1021 driver.

And you are sure you have this hardware device?  Is that what the
sensors package for 2.4 uses?  And 2.4 works just fine, right?

If so, I suggest you ask the sensors developers on their mailing list as
this is a driver specific issue, and doesn't sound like a problem due to
the 2.5 port.

> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0018
> i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=30, DAT0=ff, DAT1=ff
> i2c_adapter i2c-0: Error: no response!

It's really looking like the driver is trying to talk to a device that
isn't present, hence the timeouts.

thanks,

greg k-h
