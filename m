Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279170AbRKAPre>; Thu, 1 Nov 2001 10:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279190AbRKAPrY>; Thu, 1 Nov 2001 10:47:24 -0500
Received: from cs.columbia.edu ([128.59.16.20]:64469 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S279170AbRKAPrK>;
	Thu, 1 Nov 2001 10:47:10 -0500
Date: Thu, 1 Nov 2001 10:47:03 -0500
Message-Id: <200111011547.fA1Fl3B23182@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xircom_cb and promiscious mode
In-Reply-To: <20011101112628.A30743@torres.ka0.zugschlus.de>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001 11:26:28 +0100, Marc Haber <mh+linux-kernel@zugschlus.de> wrote:

> I am quite interested in the problems that arise with the xircom
> cardbus ethernet cards, since I have difficulties with them as well.
> However, my problems are not solved by setting promisc mode.

Indeed, this sounds like a very different problem.

> When I try to transmit larger amounts of data (such as scp'ing a 30 MB
> file over from a different machine on the LAN), network transfer
> stalls. I can abort the user space program, but the network link is
> gone.

Ok, so let's take a closer look at this. I am mostly interested in the 
behavior of the xircom_tulip_cb from 2.4.13+ and 2.4.12-ac4+ kernels.

When you say the network link is gone, does it mean the network link light 
on the card is gone? What does mii-tool report?

Do you get any kernel messages when the networking dies? Any netdev 
transmit timeouts or anything else?

What are the messages you get from xircom_tulip_cb when it gets 
initialized? [make sure you look at dmesg's output, some syslog 
configurations don't log all kernel messages.]

Can you run tcpdump on the other side of the scp connection to see what 
exactly is going on?

> Is it possible that I am doing something wrong?

It's very unlikely... but possible. :-)

> 2.4.13-ac5 has the patched xircom_tulip_cb from 2.4.13-pre3?

It does.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
