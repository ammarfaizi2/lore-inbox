Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263384AbRFAFLS>; Fri, 1 Jun 2001 01:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263386AbRFAFLI>; Fri, 1 Jun 2001 01:11:08 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:12303 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S263384AbRFAFK6>;
	Fri, 1 Jun 2001 01:10:58 -0400
Message-ID: <3B1726B3.6ED0872C@candelatech.com>
Date: Thu, 31 May 2001 22:22:59 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John William <jw2357@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RECV network performance
In-Reply-To: <F75GMVJ7AnvcesML51O000040fe@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John William wrote:
> 
> >Depends on what is driving it...  An application I built can only push
> >about
> >80 Mbps bi-directional on PII 550Mhz machines.  It is not the most
> >efficient program in
> >the world, but it isn't too bad either...
> >
> >I missed the rest of this thread, so maybe you already mentioned it, but
> >what is the bottleneck?  Is your CPU running at 100%?
> >
> >Greatly increasing the buffers both in the drivers and in the sockets
> >does wonders for higher-speed connections, btw.
> >
> >Ben
> 
> I don't know what the bottleneck is. What I'm seeing is ~60Mbps transmit
> speed and anywhere from 1 to 12Mpbs receive speed on a couple 10/100 cards
> using the 2.2.16, 2.2.19 and 2.4.3 kernels.
> 
> I have tried increasing the size of the RX ring buffer and it did not seem
> to make any difference. It appears that there is some sort of overrun or
> other problem. There is a significant slowdown between the 2.2.x and 2.4.x
> kernels.
> 
> However, just tonight, while really hammering on the system, I started to
> get some messages like "eth1: Oversized Ethernet frame spanned multiple
> buffers, status 7fff8301!". Any ideas what could be causing that?

Nope, I'd take it up with the driver developers.  For what it's worth,
the Intel Ether-Express Pro cards are the only ones I've found yet that
really work right at high speeds.  Intel's e100 driver seems to work really
well for me, but the eepro driver also works well with most versions of
the eepro cards I've used...

I have had definate problems with the natsemi (locked up), tulip (won't
autonegotiate multi-port cards correctly, or something), rtl8139 (would
lock up, haven't tried recent drivers though)....

I used to assume that Linux had the best/fastest networking support around,
but the reality is that I've had a really hard time finding hardware/drivers
that works at high speeds (60Mbps+, bi-directional).

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
