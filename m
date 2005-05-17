Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVEQLZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVEQLZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 07:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVEQLYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 07:24:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60647 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261366AbVEQLVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 07:21:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/8] ppc64: add BPA platform type
Date: Tue, 17 May 2005 13:05:12 +0200
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <200505132117.37461.arnd@arndb.de> <200505132125.34358.arnd@arndb.de> <17033.38609.60873.138572@cargo.ozlabs.ibm.com>
In-Reply-To: <17033.38609.60873.138572@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505171305.13471.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dinsdag 17 Mai 2005 09:01, Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
> > This adds the basic support for running on BPA machines.
> > So far, this is only the IBM workstation, and it will
> > not run on others without a little more generalization.
> 
> > +/* FIXME: consolidate this into rtas.c or similar */
> > +static void __init pSeries_calibrate_decr(void)
> 
> Shouldn't this be called bpa_calibrate_decr or something similar?

The function is identical to the one for pSeries, and I'd
prefer to have only one copy of it with a more generic name.
Actually, it looks like maple and perhaps pmac have a very
similar *_calibrate_decr function, so I could perhaps
just put this into time.c as generic_calibrate_decr().

[ Ben, can you tell if pSeries_calibrate_decr should work on
  all G5 macs or if it can be changed to support them as well? ]

On a similar issue, I just remembered that I wanted to
create a rtas_time.c to hold the rtc access functions
for pSeries and BPA. Do you think that's a good idea?

> > -#define	PV_630        	0x0040
> > -#define	PV_630p	        0x0041
> > +#define	PV_630		0x0040
> > +#define	PV_630p		0x0041
> 
> Hmmm, I don't think your patch needs to clean up the whitespace here.

ok.

	Arnd <><
