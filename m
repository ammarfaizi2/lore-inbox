Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316424AbSEOVhz>; Wed, 15 May 2002 17:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316449AbSEOVhy>; Wed, 15 May 2002 17:37:54 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:1774 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S316424AbSEOVhx>; Wed, 15 May 2002 17:37:53 -0400
Date: Wed, 15 May 2002 23:37:12 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: Rui Sousa <rui.sousa@laposte.net>
cc: Urban Widmark <urban@teststation.com>, <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Via-rhine problems (2.4.19-pre8)
In-Reply-To: <Pine.LNX.4.44.0205120405010.1365-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0205152322350.1416-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Rui Sousa wrote:

> On Sat, 11 May 2002, Urban Widmark wrote:
> 
> > On Sat, 11 May 2002, Rui Sousa wrote:
> > 
> > > kernel: eth0: reset did not complete in 10 ms.
> > > kernel: NETDEV WATCHDOG: eth0: transmit timed out

[snipped]

> > 
> 
> Jeff sent me is latest version and I'm already trying it out. I loaded it
> with full debug on to see if something interesting happens before the 
> transmit/reset timeout errors. Now I just need to wait a couple of 
> days...
> 
> I will keep you two informed on any developments,

Hi again,

I just got the same problem with the new driver version.
The log shows, for the first timeout error:

May 15 21:37:35 localhost dhcpcd[444]: DHCP_NAK server response received 
May 15 21:37:35 localhost dhcpcd[444]: DHCP_NAK server response received 
May 15 21:37:35 localhost kernel: eth0: reset did not complete in 10 ms.
May 15 21:37:35 localhost kernel: eth0: reset finished after 10005 
microseconds.May 15 21:38:09 localhost kernel: NETDEV WATCHDOG: eth0: 
transmit timed out
May 15 21:38:09 localhost kernel: eth0: Transmit timed out, status 0000, 
PHY status 782d, resetting...

so now I'm thinking this could be caused by dhcpd. If for example
the IP address assigned to eth0 changes how would dhcpd go about
actually carrying out the change?

I'm adding some more printk's to get at trace of 
open()/close()/ioctl()/get_stats() calls to the via-rhine driver
to try to get a better picture of the problem. 

Rui

