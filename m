Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSFDUX3>; Tue, 4 Jun 2002 16:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSFDUX2>; Tue, 4 Jun 2002 16:23:28 -0400
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:23815 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S316662AbSFDUX0>; Tue, 4 Jun 2002 16:23:26 -0400
Date: Tue, 4 Jun 2002 14:23:17 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: Re: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Message-ID: <20020604142317.B18238@mail.harddata.com>
In-Reply-To: <000101c20bd5$b8f24560$010b10ac@sbp.uptime.at> <Pine.LNX.4.33.0206040749530.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 08:19:49AM -0700, Patrick Mochel wrote:
> 
> The short of it: 2.5.19 introduced a struct bus_type that describes each
> bus type in the system.

Which immediately collided with 'static struct bus_type {...}'
hidden in drivers/net/tulip/de4x5.c and, as result, the later does
not compile anymore.  These two "bus_types" are quite dissimilar. :-)

An obvious and trivial fix was to globally replace "bus_type"
in de4x5.c with "de4x5_bus_type" (or this should be done in some
other manner).

  Michal
