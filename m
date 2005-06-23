Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVFWQn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVFWQn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVFWQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:43:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5138 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262619AbVFWQn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:43:56 -0400
Date: Thu, 23 Jun 2005 17:43:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamey Hicks <jamey.hicks@hp.com>
Cc: dpervushin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
Message-ID: <20050623174349.A12573@flint.arm.linux.org.uk>
Mail-Followup-To: Jamey Hicks <jamey.hicks@hp.com>, dpervushin@gmail.com,
	linux-kernel@vger.kernel.org
References: <1119529135.4739.6.camel@diimka.dev.rtsoft.ru> <42BADA42.9090908@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42BADA42.9090908@hp.com>; from jamey.hicks@hp.com on Thu, Jun 23, 2005 at 11:50:26AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 11:50:26AM -0400, Jamey Hicks wrote:
> dmitry pervushin wrote:
> >we finally decided to rework the SPI core and now it its ready for your comments.. 
> >Here we have several boards equipped with SPI bus, and use this spi core with these boards; 
> >Drivers for them are available by request (...and if community approve this patch)
> 
> I'm glad to see that work is progressing on SPI core.  I've worked on 
> drivers on both ARM linux and Blackfin uclinux that use SPI and would 
> prefer that they not be platform specific.

I worry about SPI at the moment because I can't see how it's being used
from just this code.

The worry I have is that it appears to contain an algorithm layer.  Would
this be better as a library for drivers to use, or something like that?

The reason I bring up this point is that my L3 layer is over-complex
for what it does (despite being about 378 lines) because it tried far
too hard to look like the I2C layer - soo much so I'm not happy with
it for mainline.

(I also have some concerns with the amount of NULL pointer checking in
the SPI code...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
