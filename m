Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275621AbRIZV3h>; Wed, 26 Sep 2001 17:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275623AbRIZV32>; Wed, 26 Sep 2001 17:29:28 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29428 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275618AbRIZV3O>; Wed, 26 Sep 2001 17:29:14 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 26 Sep 2001 15:29:09 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [patch] netconsole - log kernel messages over the network. 2.4.10.
Message-ID: <20010926152909.D1140@turbolinux.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0109262128320.8277-100000@localhost.localdomain> <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109261635190.957-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001, Ingo Molnar wrote:
> sample startup of the netconsole on the server:
> 
>      insmod netconsole dev=eth1 target_ip=0x0a000701 \
>                   source_port=6666 \
>                   target_port=6666 \
>                   target_eth_byte0=0x00 \
>                   target_eth_byte1=0x90\
>                   target_eth_byte2=0x27 \
>                   target_eth_byte3=0x8C \
>                   target_eth_byte4=0xA0 \
>                   target_eth_byte5=0xA8

Ugh.  Maybe a wrapper script (netconsole-server) which automates this is
in order?  I imagine the eth_byteX is a MAC address (or at least that this
is in the documentation)?

> > and on the client:
> > 
> > 	# ./netconsole-client -server 10.0.7.5 -client 10.0.7.1 -port 6666
> >         [...network console startup...]
> >         netconsole: network logging started up successfully!
> >         SysRq : Loglevel set to 9

<wishlist>
Any chance the netconsole-client can be set up to listen for multiple hosts
and log to the local syslog?  This would allow you to run netconsole-client
on your normal syslog host and add timestamps, clean up old logs, etc.

I take it that this is only a one-way interface (i.e. logs sent from the
server to the client), and not a real serial-console replacement?
</wishlist>

In any case, this will be EXTREMELY useful for me, as a lot of new machines
do not have serial ports and are a PITA to debug in case of a crash.  Thanks.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

