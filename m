Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271685AbTGRCPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271683AbTGRCPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:15:39 -0400
Received: from d40.sstar.com ([209.205.179.40]:20223 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S271681AbTGRCPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:15:37 -0400
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: i2c-proc module
Date: Thu, 17 Jul 2003 21:30:27 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200307170540.26684.andy@asjohnson.com> <3F168855.50708@wmich.edu>
In-Reply-To: <3F168855.50708@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307172130.27869.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 July 2003 06:28 am, Ed Sweetman wrote:
> Andrew S. Johnson wrote:
> > I2C wants an i2c-proc module, but I can't find where
> > to config it.  Something like this happens when I run sensors:
> > 
> > /proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
> > Make sure you have done 'modprobe i2c-proc'!
> > 
> > There was an i2c-proc module with lm_sensors 2.7.0.  What
> > am I missing?
> > 
> > Andy Johnson
> 
> 
> lm_sensors uses sysfs now. Not proc. Sensors hasn't been updated. You'll 
> have to use cat.

It seems that by trial and error I figured it out.  There's a i2c-dev module that
I have to load first, then via686a, then i2c-isa.  This order is different than with
lm_sensors under 2.4 kernels.  Also, the i2c-viapro was required before, but
now it doesn't seem to do anything.

Thanks for helping,

Andy Johnson

