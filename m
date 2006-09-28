Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWI1IyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWI1IyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 04:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWI1IyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 04:54:24 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:32243 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751145AbWI1IyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 04:54:23 -0400
Date: Thu, 28 Sep 2006 10:54:36 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] at91_serial -> atmel_serial: Kconfig symbols
Message-ID: <20060928105436.73aeb23d@cad-250-152.norway.atmel.com>
In-Reply-To: <1159432488.23157.25.camel@fuzzie.sanpeople.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com>
	<115937628584-git-send-email-hskinnemoen@atmel.com>
	<11593762852168-git-send-email-hskinnemoen@atmel.com>
	<11593762851735-git-send-email-hskinnemoen@atmel.com>
	<1159432488.23157.25.camel@fuzzie.sanpeople.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Sep 2006 10:34:49 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> hi Haavard,
> 
> > Rename the following Kconfig symbols:
> >   * CONFIG_SERIAL_AT91 -> CONFIG_SERIAL_ATMEL
> >   * CONFIG_SERIAL_AT91_CONSOLE -> CONFIG_SERIAL_ATMEL_CONSOLE
> >   * CONFIG_SERIAL_AT91_TTYAT -> CONFIG_SERIAL_ATMEL_TTYAT
> 
> 
> > -config SERIAL_AT91
> > -	bool "AT91RM9200 / AT91SAM9261 serial port support"
> > +config SERIAL_ATMEL
> > +	bool "AT91 / AT32 on-chip serial port support"
> >  	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261)
> >  	select SERIAL_CORE
> >  	help
> >  	  This enables the driver for the on-chip UARTs of the
> > Atmel AT91RM9200 and AT91SAM926 processor.
> 
> Shouldn't this dependency be:
>    depends on (ARM && ARCH_AT91) || AVR32
> 
> (The "ARCH_AT91RM9200 || ARCH_AT91SAM9261" can be replaced with
> ARCH_AT91 since the driver should usable on the RM9200, SAM9261 and
> SAM9260)

Oh, I didn't know that symbol existed. I just looked at the serial
Kconfig, not arch/arm/Kconfig. You're right of course.

> The help text should probably also be updated for these 3 options so
> that it mentions the AVR32.

Right. Probably shouldn't have changed the prompt -- I have a different
patch that actually adds AVR32 support (I don't want to do that before
it actually compiles on AVR32, in case some crazy person comes along
and tries out allyesconfig ;)

Is it OK if I keep the patch as it is and change the dependency and
help text in a later patch?

Haavard
