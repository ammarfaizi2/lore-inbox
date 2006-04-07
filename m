Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWDGOne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWDGOne (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWDGOne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:43:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40209 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932434AbWDGOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:43:32 -0400
Date: Fri, 7 Apr 2006 15:43:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: SDIO Drivers?
Message-ID: <20060407144314.GB21049@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Ram <vshrirama@gmail.com>, linux-kernel@vger.kernel.org
References: <8bf247760604040130n155eeffauc5798750f8357bca@mail.gmail.com> <443628F3.9050107@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443628F3.9050107@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 10:55:15AM +0200, Pierre Ossman wrote:
> Ram wrote:
> > Hi,
> >    i want to write an SDIO driver. There is not much information of
> > what an SDIO driver is
> >    supposed to do or any sample sdio drivers.
> > 
> >    I have a few questions regarding that:
> > 
> >    1) What is an SDIO Driver?.
> > 
> 
> They don't exist in the kernel right now, that's why you haven't found
> any examples.
> 
> To support SDIO, the MMC layer would need to be extended to handle the
> initialisation of SDIO cards (they're a bit different from SD storage
> and MMC). After that, a driver model needs to be constructed. It might
> be possible to build upon the current MMC driver model, but one would
> need to make sure that cards that are both storage and SDIO are handled.

I think we would be forced to re-think the existing model - SDIO cards
seem to be able to support simultaneously both block device and IO.
Therefore, it would appear that we need the ability to register two
drivers against the same device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
