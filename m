Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLEXZX>; Tue, 5 Dec 2000 18:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLEXZN>; Tue, 5 Dec 2000 18:25:13 -0500
Received: from cr355197-a.poco1.bc.wave.home.com ([24.112.113.88]:54013 "EHLO
	whiskey.enposte.net") by vger.kernel.org with ESMTP
	id <S129849AbQLEXZE>; Tue, 5 Dec 2000 18:25:04 -0500
Date: Tue, 5 Dec 2000 14:55:35 -0800
From: Stuart Lynne <sl@fireplug.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
Message-ID: <20001205145535.A13431@fireplug.net>
Reply-To: Stuart Lynne <sl@fireplug.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have a vested interest in how this all turns out.  I own a Packet Over SONET
> device driver for our OC-12 and OC-48 NICs that I currently pass all parameters
> to the driver via arguments on the insmod.  To avoid lengthy commands, we
> provide the common defaults.  We accept some basic ifconfig input, but with
> SONET/SDH and chip specific items that needed to be controlled, ifconfig did not
> seem the way to go.

Ditto, we have an adsl driver that we setup by overloading various otherwise
unused options in ifconfig (mem_start, io_addr etc) to do this. Cheaper and
faster than writing yet another ioctl using device configuration agent, but
distasteful non the less.

Some generic way to pass configuration data using a generic configuration
agent to network (and other) drivers would be interesting.

> > > I'm willing to go for this implementation, but I wanted to know first:
> > > - whether ifconfig is the right place to do it;
> > > - where I should create the new ioctl's to handle these new parameters.
> >
> > I think a new ioctl would be sensible. There is a lot to go in it.
 
-- 
                                            __O 
Fireplug - a Lineo company                _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>         www.lineo.com         604-461-7532
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
