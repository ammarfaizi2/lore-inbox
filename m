Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268841AbRHBHfb>; Thu, 2 Aug 2001 03:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268845AbRHBHfL>; Thu, 2 Aug 2001 03:35:11 -0400
Received: from home.paris.trader.com ([195.68.19.162]:17102 "EHLO
	smtp-gw.netclub.com") by vger.kernel.org with ESMTP
	id <S268841AbRHBHfF>; Thu, 2 Aug 2001 03:35:05 -0400
Message-ID: <3B6902C4.9B975BEE@trader.com>
Date: Thu, 02 Aug 2001 09:35:32 +0200
From: joseph.bueno@trader.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-5mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Guyett <justin@soze.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tulip driver still broken
In-Reply-To: <Pine.LNX.4.33.0108011354120.8520-100000@kobayashi.soze.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Guyett wrote:
> 
> On Wed, 1 Aug 2001 joseph.bueno@trader.com wrote:
> 
> > I am currently using a Xircom Ethernet adapter (tulip_cb module) with a
> > 2.4.5 kernel.
> >
> > The only way I have found to make it work is to turn on promiscuous mode
> > (with 'tcpdump -i eth0 -n > /dev/null') after bootup. I can turn it off
> > after a few minutes without problem.
> 
> i saw something like that with a wireless ethernet card, but presumed it
> to be something wrong with WAP+multicast, plus it doesn't happen with new
> card firmware.
> 
> at any rate, this made my card work, and sounds like it would be better
> than running tcpdump and killing it after a few minutes.  the critical
> element in getting things working was getting traffic while the interface
> was in promisc mode (arp replies to wrong mac address maybe?)
> 

That's right.
In fact, I generally start a ping to a remote IP address after bootup
and, if I don't get any response (which is always the case), I start
tcpdump and I do some network activity before stopping it.

> ifconfig ethX promisc
> ping -n -c 5 <pick a remote ip>
> ifconfig ethX -promisc

In fact, I ran tcpdump to check what was going on and, since it "solved"
the problem, I didn't check for a better way to do it.
Obviously, your solution is better.

> 
> if you have no traffic for a few minutes, it might break again.

Hopefully, there is some periodic network activity on my machine (at
least checking of my POP account), so it doesn't break.

> 
> justin

Thanks
--
Joseph Bueno
NetClub/Trader.com
