Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263897AbTDDSuL (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbTDDSuL (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:50:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:21946 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263897AbTDDSuK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:50:10 -0500
Date: Fri, 4 Apr 2003 11:02:23 -0800
From: Greg KH <greg@kroah.com>
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: Burton Windle <bwindle@fint.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk9 compile problem
Message-ID: <20030404190223.GA1913@kroah.com>
References: <Pine.LNX.4.43.0304041217230.1464-100000@morpheus> <200304041932.19272.freesoftwaredeveloper@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304041932.19272.freesoftwaredeveloper@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 07:32:19PM +0200, Michael Buesch wrote:
> On Friday 04 April 2003 19:17, you wrote:
> > CONFIG_I2C_SENSOR=m
> >
> > Set this to y and recompile.
> 
> When I set this to y and do a
> make bzImage
> or a
> make menuconfig
> it's automatically reset to m.
> 
> What's the options for CONFIG_I2C_SENSOR in menuconfig (I didn't find it).

It should be set based on the rule in drivers/i2c/chips/Kconfig.
Basically if any of the drivers in that directory, then the option
should be enabled.

It works if you select those drivers as modules :)

I need to work on it today to handle the fact when you build the drivers
into the kernel, sorry for not testing that option.

greg k-h
