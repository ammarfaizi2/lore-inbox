Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272139AbSISSJ1>; Thu, 19 Sep 2002 14:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272164AbSISSJ0>; Thu, 19 Sep 2002 14:09:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12553 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S272139AbSISSJ0>;
	Thu, 19 Sep 2002 14:09:26 -0400
Message-ID: <3D8A13E4.6010300@mandrakesoft.com>
Date: Thu, 19 Sep 2002 14:13:56 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: netdev@oss.sgi.com, Jason Lunz <lunz@falooley.org>,
       Richard Gooch <rgooch@ras.ucalgary.ca>,
       "Patrick R. McManus" <mcmanus@ducksong.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       edward_peng@dlink.com.tw
Subject: Re: PATCH: sundance #2
References: <Pine.LNX.4.44.0209191316300.29420-100000@beohost.scyld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> +/* Set iff a MII transceiver on any interface requires mdio preamble.
> +   This only set with older tranceivers, so the extra
> +   code size of a per-interface flag is not worthwhile. */
> +static int mii_preamble_required = 0;
> 
> You can get rid of this as a module option, and make it a per-interface
> setting. 
> The transceiver on the Kendin chip requires this (rather old-fashioned)
> access method, while none of the previous Sundance-based boards with
> external transceivers did.
> 
> I added it as a module parameter as a back-up over-ride, but I'm certain
> that the automatic detection works.

Good enough for me...


>>				Theory of Operation
> 
> 
> Whoever changed the transmit path should update the TOO.  

noted



> -	{"Sundance Technology Alta", {0x020113F0, 0xffffffff,},
> -	 PCI_IOTYPE, 128, CanHaveMII},
> +	{"D-Link DFE-550TX FAST Ethernet Adapter"},
> +	{"D-Link DFE-550FX 100Mbps Fiber-optics Adapter"},
> 
> Yeah, you should probably throw away the rest of the changes.
> You are probably going to want to keep the drv_flags field.  I know
> that all of the current chips have the same flag (CanHaveMII), but...


That's probably a style area that you and I will disagree on... :)

	Jeff


