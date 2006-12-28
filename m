Return-Path: <linux-kernel-owner+w=401wt.eu-S1754973AbWL1UsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbWL1UsZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754974AbWL1UsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:48:24 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:30388 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754969AbWL1UsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:48:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=NAikzAiWeAdLuucjVvsK890GDYvrIyPO0jSUNBfywg3sK8qpFQM4BjwaayP4+zseEQrCEjXXLqjcGG6LBd1s4Mhthyqy6tyoxVyjFez5TQ/Tbou7HqZQBwUYuv0aG/FkCv7gYCKF805hwT9emWQMhIiAwEM1VNzKK5a5b7KuYqQ=  ;
X-YMail-OSG: Z0Zqya0VM1kFPZXLIahZUeHJjyxlFijB5WjLrr5GSjwer4UWzTUgD2A_RItvVnHBw9B1Crd2Ta0Yxv5TAbfhdlenhtfXknQNQsgajQGvpBd9RC3rXrXjMhsQcoFUl_AcbUucco7nEGRkX6o-
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
Date: Thu, 28 Dec 2006 12:48:20 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201312.36616.david-b@pacbell.net> <20061227175344.GC4088@ucw.cz>
In-Reply-To: <20061227175344.GC4088@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281248.21325.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 9:53 am, Pavel Machek wrote:
> Hi!
> 
> > Arch-neutral GPIO calls for PXA.
> > 
> > From: Philipp Zabel <philipp.zabel@gmail.com>
> 
> Missing s-o-b?

Yes, still ...

> > +static inline int gpio_direction_input(unsigned gpio)
> > +{
> > +	if (gpio > PXA_LAST_GPIO)
> > +		return -EINVAL;
> > +	pxa_gpio_mode(gpio | GPIO_IN);
> > +}
> 
> Missing return 0?
> 
> > +static inline int gpio_direction_output(unsigned gpio)
> > +{
> > +	if (gpio > PXA_LAST_GPIO)
> > +		return -EINVAL;
> > +	pxa_gpio_mode(gpio | GPIO_OUT);
> > +}
> > +
> 
> And here?

You're looking at about the oldest version of that patch.
Admittedly there were too many floating around...
