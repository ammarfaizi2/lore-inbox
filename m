Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271495AbTGQPUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271498AbTGQPUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:20:43 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:9617 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S271495AbTGQPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:19:34 -0400
Date: Fri, 18 Jul 2003 01:33:48 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com, frodol@dds.nl
Cc: linux-kernel@vger.kernel.org, phil@netroedge.com
Subject: Re: 2.6.0-t1: i2c+sensors still whacky
Message-ID: <20030717153348.GO4612@zip.com.au>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com> <20030716224718.GA4612@zip.com.au> <20030716225452.GA3419@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716225452.GA3419@kroah.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:54:52PM -0700, Greg KH wrote:
> On Thu, Jul 17, 2003 at 08:47:18AM +1000, CaT wrote:
> > On Wed, Jul 16, 2003 at 12:31:35AM -0700, Greg KH wrote:
> > > Then just load the i2c_piix4 module.  If things still work just fine,
> > > then try the i2c-adm1021 driver.  See what the kernel log says then.
> > 
> > All went well till the last step of loading the adm1021 driver.
> 
> And you are sure you have this hardware device?  Is that what the

Yes. I am very definate that this worked in past 2.5 kernels. Remember
how it used to turn my laptop off under load? I was able to read my
temps and stuff though.

> sensors package for 2.4 uses?  And 2.4 works just fine, right?

I don't use 2.4. Haven't for ages.

> If so, I suggest you ask the sensors developers on their mailing list as
> this is a driver specific issue, and doesn't sound like a problem due to
> the 2.5 port.

I've added them to To/Cc. (Hey folks :) The full thread is available
here:

http://marc.theaimsgroup.com/?t=105826046600003&r=1&w=2

If you could have a look I'd really appreciate it.

> > i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0018
> > i2c_adapter i2c-0: Transaction (pre): CNT=00, CMD=09, ADD=30, DAT0=ff, DAT1=ff
> > i2c_adapter i2c-0: Error: no response!
> 
> It's really looking like the driver is trying to talk to a device that
> isn't present, hence the timeouts.

I tried the other drivers and they all failed nicely and without hassle. I
looked through my past .config files and this is the driver that appears
the most in use.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
