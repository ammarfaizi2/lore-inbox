Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLEKNN>; Tue, 5 Dec 2000 05:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQLEKND>; Tue, 5 Dec 2000 05:13:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129383AbQLEKMy>; Tue, 5 Dec 2000 05:12:54 -0500
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
To: lists@cyclades.com (Ivan Passos)
Date: Tue, 5 Dec 2000 09:41:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List),
        philb@gnu.org (Philip Blundell), netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.10.10012042135090.5269-100000@main.cyclades.com> from "Ivan Passos" at Dec 04, 2000 09:58:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143Ebi-000500-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Media: V.35, RS-232, X.21, T1, E1
		DS1, DS3, ...

> - Protocol: Frame Relay, (Cisco)-HDLC, PPP, X.25 (not sure whether that is
>             already supported by the 'hw' option)

Not nicely. 

> - Clock: 'ext' (or 0, which implies external clock) or some numeric value
>          > 0 (which implies internal clock); setting it to 'int' would set
>          it to some fixed numeric value > 0 (useful for T1/E1 links, just
>          to indicate master clock as opposed to slave or 'ext' clock) 

Yep

> I'm sure that _all_ the other sync cards need to configure the _same_
> parameters (or a subset of them), and there may be cards that need even

And more

Generic Z85x30 drivers can run with multiple framing CRC versions (all the
chip can do in theory). So I think you need

	bitcoding		[NRZ, NRZI]
	crctype			CRC16, ...
	hunt

> I'm willing to go for this implementation, but I wanted to know first:
> - whether ifconfig is the right place to do it;
> - where I should create the new ioctl's to handle these new parameters.

I think a new ioctl would be sensible. There is a lot to go in it. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
