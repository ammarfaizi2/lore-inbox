Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSHJR7M>; Sat, 10 Aug 2002 13:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSHJR7M>; Sat, 10 Aug 2002 13:59:12 -0400
Received: from aba.krakow.pl ([62.233.163.30]:56741 "HELO two.aba.krakow.pl")
	by vger.kernel.org with SMTP id <S317110AbSHJR7L>;
	Sat, 10 Aug 2002 13:59:11 -0400
Date: Sat, 10 Aug 2002 20:02:56 +0200
From: =?iso-8859-2?Q?Pawe=B3?= Krawczyk <kravietz@aba.krakow.pl>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: zhengchuanbo <zhengcb@netpower.com.cn>,
       "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: about the tuning of eepro100
Message-ID: <20020810180256.GD25611@aba.krakow.pl>
References: <200208101742654.SM00824@zhengcb> <20020810095126.GF21239@aba.krakow.pl> <20020810185558.C306@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020810185558.C306@kushida.apsleyroad.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2002 at 06:55:58PM +0100, Jamie Lokier wrote:

> I don't think you will get better than 90% performance, but if you do
> please let me know!  I have written another e100 driver, in an attempt
> to transmit and receive small packets at the maximum possible rate.
> In tests, it would not even transmit at 100% small packets on our 82558.
> (I didn't do that test on our 82559).

Maybe we were looking for separate things - I had a firewall box with
100base-TX interfaces and when flooding it at full rate with small
(40 bytes, i.e. empty IP headers) packets the system was unusable
because of the interrupt rate. After I turned the bundling on, there
was no signs of overload. Of course, I tested throughput of the
card as well but on the IP level there was no difference I could
worry about. But as I said, this was a firewall box and I was looking
for a way to stop possible DOS, not for tiny packet delivery time
slowdown, which may be important in other applications.

-- 
Pawe³ Krawczyk, Kraków, Poland  http://echelon.pl/kravietz/
crypto: http://ipsec.pl/
horses: http://kabardians.com/
