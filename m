Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289496AbSBJLL5>; Sun, 10 Feb 2002 06:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289504AbSBJLLs>; Sun, 10 Feb 2002 06:11:48 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:26829 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S289496AbSBJLLc>; Sun, 10 Feb 2002 06:11:32 -0500
Date: Sun, 10 Feb 2002 12:11:30 +0100
From: bert hubert <ahu@ds9a.nl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ingress policing still not working in 2.4?
Message-ID: <20020210121130.A4814@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020209114529.GA6753@links2linux.de> <20020210005636.A21350@outpost.ds9a.nl> <20020210085521.GA2153@links2linux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020210085521.GA2153@links2linux.de>; from marc.schiffbauer@links2linux.de on Sun, Feb 10, 2002 at 08:56:42AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2002 at 08:56:42AM +0000, Marc Schiffbauer wrote:

> > > Before that I successfully did this:
> > > # install root CBQ
> > > DEV=ppp0
> > > UPLINK=100
> > > DOWNLINK=750
> > > tc qdisc add dev $DEV root handle 1: cbq avpkt 1000 bandwidth 100mbit
> > 
> > The WonderShaper! 
> > 
> What?

That's the name of this script.

> Ok, I changed the 10mbit to 100mbit because this is my LAN speed
> here. I first didn't see, that the root handle is per device.

I haven't yet seen DSL devices that talk 100mbit, btw. But there might be.

> But
> tc qdisc add dev $DEV root handle 1: cbq avpkt 1000 bandwidth 10mbit
> 
> is exactly the line from your HOWTO. So what will be proper values
> for my DSL Line with 128kbit up and 768kbit downstream?

I get a lot of email about this script and generally it requires some
tuning. Not all kbits are equal it appears. Some ISPs measure without ip
overhead, some with, other ISPs include PPP overhead, or PPPoA overhead, so
there is no general rule.

Whenever I deploy this script I spend some time tuning the UPLINK and
DOWNLINK values until I get the best results (maximum speed, but no
queueuing).

Good luck!

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
