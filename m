Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVFHWgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVFHWgG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVFHWgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:36:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19598 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262177AbVFHWfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:35:55 -0400
Date: Thu, 9 Jun 2005 00:34:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Ketrenos <jketreno@linux.intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Netdev list <netdev@oss.sgi.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       "James P. Ketrenos" <ipw2100-admin@linux.intel.com>
Subject: Re: ipw2100: firmware problem
Message-ID: <20050608223437.GB2614@elf.ucw.cz>
References: <20050608142310.GA2339@elf.ucw.cz> <42A723D3.3060001@linux.intel.com> <20050608212707.GA2535@elf.ucw.cz> <42A76719.2060700@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A76719.2060700@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Having a parameter to control this seems a bit too complex to me.
> >
> >How is 
> >
> >insmod ipw2100 enable=1
> >
> >different from
> >
> >insmod ipw2100
> >iwconfig eth1 start_scanning_or_whatever
> >
> >?
> It defaults to enabled, so you just need to do:
> 
>     insmod ipw2100
> 
> and it will auto associate with an open network.  For the use case where
> users want the device to load but not initialize, they can use
> 
>     insmod ipw2100 disable=1
> 
> If hotplug and firmware loading worked early in the init sequence, no
> one would have issue with the current model; it works as users expect it
> to work.  It magically finds and associates to networks, and your
> network scripts can then kick off DHCP, all with little to no special
> crafting or utility interfacing. 

Actually it would still transmit when user did not want it to. I
believe that staying "quiet" is right thing, long-term. And it could
solve firmware-loading problems, short-term...

How long does association with AP take? Anyway it should be easy to
tell driver to associate ASAP, just after the insmod...
								Pavel
