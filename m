Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129737AbRCCUWS>; Sat, 3 Mar 2001 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCCUWI>; Sat, 3 Mar 2001 15:22:08 -0500
Received: from ezri.xs4all.nl ([194.109.253.9]:50664 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S129737AbRCCUV4>;
	Sat, 3 Mar 2001 15:21:56 -0500
Date: Sat, 3 Mar 2001 21:21:48 +0100 (CET)
From: Eric Lammerts <eric@lammerts.org>
To: Jon Masters <jonathan@jonmasters.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Forwarding broadcast traffic
In-Reply-To: <200103031054.KAA29868@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0103032107110.7771-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 3 Mar 2001, Jon Masters wrote:
> e.g. on desktop a broadcast udp packet (with a specified port) needs to
> go not only to itself and the router but also the "REST OF LAN" part
> too - and vice versa. Removing the router is not an option.

Write an application that creates 2 sockets listening on the same port
but different interfaces (using the SO_BINDTODEVICE socket option, see
the dhcp source for an example). Then forward any packet you receive
on one socket to the other side. If you need to keep the source ip
intact, you may have to use a raw socket for the sending part.

You could adapt a DHCP relay program to do this stuff instead of
writing it from scratch.

Eric

-- 
Eric Lammerts <eric@lammerts.org> | "An NT server can be run by
http://www.lammerts.org           |  an idiot, and usually is."

