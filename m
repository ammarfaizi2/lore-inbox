Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLEPqI>; Tue, 5 Dec 2000 10:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129821AbQLEPqD>; Tue, 5 Dec 2000 10:46:03 -0500
Received: from auemail1.lucent.com ([192.11.223.161]:48608 "EHLO
	auemlsrv.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S129226AbQLEPpy>; Tue, 5 Dec 2000 10:45:54 -0500
Message-ID: <3A2D068E.604FE486@lucent.com>
Date: Tue, 05 Dec 2000 10:15:26 -0500
From: gparrott@lucent.com (Greg Parrott)
Organization: Lucent Technologies - Optical Area Networks
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <E143Ebi-000500-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a vested interest in how this all turns out.  I own a Packet Over SONET
device driver for our OC-12 and OC-48 NICs that I currently pass all parameters
to the driver via arguments on the insmod.  To avoid lengthy commands, we
provide the common defaults.  We accept some basic ifconfig input, but with
SONET/SDH and chip specific items that needed to be controlled, ifconfig did not
seem the way to go.

Thanks!

Greg
--
Greg Parrott
Lucent Technologies, Inc.
Optical Area Networking
(919) 838-6095
http://www.lucent-optical.com/oan


Alan Cox wrote:

> > - Media: V.35, RS-232, X.21, T1, E1
>                 DS1, DS3, ...
>
> > - Protocol: Frame Relay, (Cisco)-HDLC, PPP, X.25 (not sure whether that is
> >             already supported by the 'hw' option)
>
> Not nicely.
>
> > - Clock: 'ext' (or 0, which implies external clock) or some numeric value
> >          > 0 (which implies internal clock); setting it to 'int' would set
> >          it to some fixed numeric value > 0 (useful for T1/E1 links, just
> >          to indicate master clock as opposed to slave or 'ext' clock)
>
> Yep
>
> > I'm sure that _all_ the other sync cards need to configure the _same_
> > parameters (or a subset of them), and there may be cards that need even
>
> And more
>
> Generic Z85x30 drivers can run with multiple framing CRC versions (all the
> chip can do in theory). So I think you need
>
>         bitcoding               [NRZ, NRZI]
>         crctype                 CRC16, ...
>         hunt
>
> > I'm willing to go for this implementation, but I wanted to know first:
> > - whether ifconfig is the right place to do it;
> > - where I should create the new ioctl's to handle these new parameters.
>
> I think a new ioctl would be sensible. There is a lot to go in it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
