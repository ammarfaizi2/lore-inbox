Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSHJSPR>; Sat, 10 Aug 2002 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSHJSPR>; Sat, 10 Aug 2002 14:15:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21007 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317176AbSHJSPQ>;
	Sat, 10 Aug 2002 14:15:16 -0400
Message-ID: <3D55590E.4020902@mandrakesoft.com>
Date: Sat, 10 Aug 2002 14:18:54 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Pawe=B3_Krawczyk?= <kravietz@aba.krakow.pl>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       zhengchuanbo <zhengcb@netpower.com.cn>,
       "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>
Subject: Re: about the tuning of eepro100
References: <200208101742654.SM00824@zhengcb> <20020810095126.GF21239@aba.krakow.pl> <20020810185558.C306@kushida.apsleyroad.org> <20020810180256.GD25611@aba.krakow.pl>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawe³ Krawczyk wrote:
> On Sat, Aug 10, 2002 at 06:55:58PM +0100, Jamie Lokier wrote:
> 
> 
>>I don't think you will get better than 90% performance, but if you do
>>please let me know!  I have written another e100 driver, in an attempt
>>to transmit and receive small packets at the maximum possible rate.
>>In tests, it would not even transmit at 100% small packets on our 82558.
>>(I didn't do that test on our 82559).
> 
> 
> Maybe we were looking for separate things - I had a firewall box with
> 100base-TX interfaces and when flooding it at full rate with small
> (40 bytes, i.e. empty IP headers) packets the system was unusable
> because of the interrupt rate. After I turned the bundling on, there
> was no signs of overload. Of course, I tested throughput of the
> card as well but on the IP level there was no difference I could
> worry about. But as I said, this was a firewall box and I was looking
> for a way to stop possible DOS, not for tiny packet delivery time
> slowdown, which may be important in other applications.


Sounds like you need the NAPI version of eepro100 or e100...  NAPI is 
designed to eliminate the overhead that you describe.

	Jeff




