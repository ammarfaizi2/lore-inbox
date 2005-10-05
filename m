Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVJEJBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVJEJBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVJEJBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:01:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8460 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932581AbVJEJBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:01:45 -0400
Date: Wed, 5 Oct 2005 10:01:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
       stephen@streetfiresound.com, dpervushin@gmail.com,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 1/2] simple SPI framework
Message-ID: <20051005090129.GB7208@flint.arm.linux.org.uk>
Mail-Followup-To: Vitaly Wool <vwool@ru.mvista.com>,
	David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
	stephen@streetfiresound.com, dpervushin@gmail.com,
	Pavel Machek <pavel@ucw.cz>
References: <20051004180241.0EAA5EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <4343898D.1060904@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343898D.1060904@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 12:06:37PM +0400, Vitaly Wool wrote:
> David,
> 
> >+#ifdef	CONFIG_PM
> >+
> >+/* Suspend/resume in "struct device_driver" don't really need that
> >+ * strange third parameter, so we just make it a constant and expect
> >+ * SPI drivers to ignore it just like most platform drivers do.
> >+ *
> > 
> >
> So you just ignored my letter on that subject :(
> The fact that you don't need it doesn't mean that other people won't.
> The fact that there's no clean way to suspend USB doesn't mean that 
> there shouldn't be one for SPI.

The third parameter is obsolete and should only be used to select _one_
of the tree suspend calls you will get.

Any additional suspend calls should _not_ create extra usage of this
parameter.  It's a left over from Pat's first driver model incarnation
which is specific to the platform device drivers.  (Mainly it exists
because no one can be bothered to clean it up.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
