Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130573AbRA2Sem>; Mon, 29 Jan 2001 13:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbRA2Sed>; Mon, 29 Jan 2001 13:34:33 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:16395 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129532AbRA2SeN>; Mon, 29 Jan 2001 13:34:13 -0500
Date: Mon, 29 Jan 2001 19:31:36 +0100
From: Jamie Lokier <ln@tantalophile.demon.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, John Fremlin <vii@altern.org>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulus@linuxcare.com,
        linux-ppp@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] dynamic IP support for 2.4.0 (SIOCKILLADDR)
Message-ID: <20010129193136.A11035@pcep-jamie.cern.ch>
In-Reply-To: <m2d7d838sj.fsf@boreas.yi.org.> <200101290245.f0T2j2Y438757@saturn.cs.uml.edu> <20010129135905.B1591@fred.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010129135905.B1591@fred.local>; from ak@muc.de on Mon, Jan 29, 2001 at 01:59:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > I get the same IP about 2/3 of the time, so it is pretty important
> > to avoid killing connections until after the new IP is known.
> 
> I prefer it when the IP is killed as soon as possible so that I can see
> when the connection is lost (ssh sessions get killed etc.)

I like it when I get the same IP back and can continue an ssh session.
My line drops regularly in mid session.

Unfortunately getting the same IP is rare now, so I've been toying with
running a PPP tunnel through a fixed host out on the net.  The tunnel
would be dropped and recreated with each new connection.  My local link
IP would change, but the tunnel IP would not so connections to other
places, ssh etc. would all be from the tunnel IP.

The important thing is that the tunnel is destroyed and recreated (it
has to be, it is over different underlying link addresses).  I do not
want that to destroy the connections from the tunnelled address.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
