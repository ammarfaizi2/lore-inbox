Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVLNT1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVLNT1F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVLNT1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:27:04 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:39348 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964891AbVLNT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:27:03 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Date: Wed, 14 Dec 2005 10:50:54 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com>
In-Reply-To: <43A05C32.3070501@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141050.55294.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 9:53 am, Vitaly Wool wrote:
> Greg KH wrote:
> 
> >What is the speed of your SPI bus?
> >
> >And what are your preformance requirements?
> >  
> >
> The maximum frequency for the SPI bus is 26 MHz, WLAN driver is to work 
> at true 10 Mbit/sec.

Some SPI flash chips are rated at 60 MHz ... there's no "official"
standard placing such limits on SPI.

The various IEEE 802.15.4 (ZigBee) transceivers seem to take up
to 10 MHz clocks, FWIW.  USB controllers, 12 MHz (surprise!  they
are of course full speed, 12 MHz).

Sensors with A-to-D converters are often lower rate; only 100K
samples per second, say, at maybe 12 bits each; more like 2 MHz.

- Dave
