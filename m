Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbVLNTRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVLNTRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbVLNTRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:17:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:8850 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964884AbVLNTRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:17:23 -0500
Date: Wed, 14 Dec 2005 11:16:42 -0800
From: Greg KH <greg@kroah.com>
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Message-ID: <20051214191642.GA31838@kroah.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <20051213191531.GA13751@kroah.com> <43A0230B.1040904@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A05C32.3070501@ru.mvista.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:53:54PM +0300, Vitaly Wool wrote:
> Greg KH wrote:
> 
> >What is the speed of your SPI bus?
> >
> >And what are your preformance requirements?
> > 
> >
> The maximum frequency for the SPI bus is 26 MHz, WLAN driver is to work 
> at true 10 Mbit/sec.

Then you should be fine with the copying data and memset stuff, based on
the workload the rest of the kernel does for other busses which have
this same requirement of DMAable buffers.

And I'm sure David will be glad to have you point out any places in his
code where it accidentally takes data off of the stack instead of
allocating it.

thanks,

greg k-h
