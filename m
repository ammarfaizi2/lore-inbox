Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268287AbRHAVPF>; Wed, 1 Aug 2001 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268265AbRHAVOz>; Wed, 1 Aug 2001 17:14:55 -0400
Received: from [64.175.255.50] ([64.175.255.50]:43932 "HELO kobayashi.soze.net")
	by vger.kernel.org with SMTP id <S268254AbRHAVOo>;
	Wed, 1 Aug 2001 17:14:44 -0400
Date: Wed, 1 Aug 2001 14:14:21 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: <joseph.bueno@trader.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tulip driver still broken
In-Reply-To: <3B683237.641478BE@trader.com>
Message-ID: <Pine.LNX.4.33.0108011354120.8520-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001 joseph.bueno@trader.com wrote:

> I am currently using a Xircom Ethernet adapter (tulip_cb module) with a
> 2.4.5 kernel.
>
> The only way I have found to make it work is to turn on promiscuous mode
> (with 'tcpdump -i eth0 -n > /dev/null') after bootup. I can turn it off
> after a few minutes without problem.

i saw something like that with a wireless ethernet card, but presumed it
to be something wrong with WAP+multicast, plus it doesn't happen with new
card firmware.

at any rate, this made my card work, and sounds like it would be better
than running tcpdump and killing it after a few minutes.  the critical
element in getting things working was getting traffic while the interface
was in promisc mode (arp replies to wrong mac address maybe?)

ifconfig ethX promisc
ping -n -c 5 <pick a remote ip>
ifconfig ethX -promisc

if you have no traffic for a few minutes, it might break again.


justin

