Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266559AbRHYSX3>; Sat, 25 Aug 2001 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270101AbRHYSXT>; Sat, 25 Aug 2001 14:23:19 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:60604 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S266559AbRHYSXE>;
	Sat, 25 Aug 2001 14:23:04 -0400
Message-ID: <3B87ED15.77741DF9@candelatech.com>
Date: Sat, 25 Aug 2001 11:23:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Willy Tarreau <wtarreau@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <200108250704.f7P741U20873@ns.home.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> 
> Hi Ben,
> 
> > Couldn't the bonding code be made to distribute pkts to one interface or
> > another based on a hash of the sending IP port or something?  Seems like that
> > would fix the reordering problem for IP packets....  It wouldn't help for
> > a single stream, but I'm guessing the real world problem involves many streams,
> > which on average should hash such that the load is balanced...
> 
> You may take a look at this for enhancements to the bonding driver :
> 
>   http://sourceforge.net/projects/bonding/
> 
> The XOR method has been implemented to hash the flows based on the SRC/DST
> MAC addresses.

If you are only hashing on MAC addresses, then you would become highly
un-optimized in the case where a machine is communicating with it's
default gateway primarily.  Perhaps the XOR hash is really more sophisticated??

Ben


> 
> Regards,
> Willy

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
