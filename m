Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265099AbSJWRGv>; Wed, 23 Oct 2002 13:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbSJWRGv>; Wed, 23 Oct 2002 13:06:51 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:18651 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265099AbSJWRFZ>;
	Wed, 23 Oct 2002 13:05:25 -0400
Message-ID: <3DB6D81F.2050309@candelatech.com>
Date: Wed, 23 Oct 2002 10:10:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
References: <200210231218.18733.roy@karlsbakk.net> <20021023130101.GA646@outpost.ds9a.nl> <1035379308.5950.3.camel@rth.ninka.net> <200210231542.48673.roy@karlsbakk.net> <20021023170102.GA5302@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> I still refuse to believe that a 1.8GHz Pentium4 can only checksum
> 250megabits/second. MD Raid5 does better and they probably don't use a
> checksum as braindead as that used by TCP.

For what it's worth, I have been able to send and receive 400+ Mbps
of traffic, by directional, on the same machine (ie, about 1600 Mbps
of payload across the PCI bus)

So, it's probably not the e1000 or networking code that is slowing you down.
(This was on a 64/66 PCI, Dual-AMD 2Ghz machine though,
are you running only 32/33 PCI?  If not, where did you find this motherboard!)

Have you tried just reading the information from disk and doing everying except
the final 'send/write/sendto' ?  That would help determine if it is your
file reads that are killing you.

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


