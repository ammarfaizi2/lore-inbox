Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSG1UQt>; Sun, 28 Jul 2002 16:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSG1UQs>; Sun, 28 Jul 2002 16:16:48 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:38093 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S317304AbSG1UQs>;
	Sun, 28 Jul 2002 16:16:48 -0400
Date: Sun, 28 Jul 2002 22:20:08 +0200
From: bert hubert <ahu@ds9a.nl>
To: Benson Chow <blc+lkml-post@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: traffic shaper in 2.4.18 working?
Message-ID: <20020728202007.GA19742@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Benson Chow <blc+lkml-post@q.dyndns.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207281337330.1415-100000@q.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207281337330.1415-100000@q.dyndns.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 01:56:49PM -0600, Benson Chow wrote:
> (initial conditions)
> I have two existing IP addresses on eth0 belonging to the same subnet as a
> virtual host.  This machine is a dual CPU box at 450MHz with an Intel
> EtherPro 100.
> 
> (what I've done)
> I've executed:
> shapecfg attach shaper0 eth0
> shapecfg speed shaper0 19000
> ifconfig shaper0 10.0.0.80
> 
> However, it seems whenever I subsequently connect to this
> machine's 10.0.0.80 from another machine, it still transmits at full
> bandwidth of the media and not the 19K (Bytes/sec?) that I expect?
> 
> Is this a proper usage of this device or is it a bug?

Add a route to your remote machine via shaper0 and check again. Linux does
not automatically route traffic with the source address of an interface out
over that interface. This is not a bug. If you want to force this, use
policy routing.

See http://lartc.org/howto/lartc.rpdb.html 

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
