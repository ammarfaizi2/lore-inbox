Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSHFT5b>; Tue, 6 Aug 2002 15:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSHFT5a>; Tue, 6 Aug 2002 15:57:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2181 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315454AbSHFT53>; Tue, 6 Aug 2002 15:57:29 -0400
Date: Tue, 6 Aug 2002 16:03:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
Subject: Re: ethtool documentation
In-Reply-To: <3D502611.26B28B8E@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020806155358.25303A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Chris Friesen wrote:

> "Richard B. Johnson" wrote:
> 
> > Because of this, there is no such thing as 'unused eeprom space' in
> > the Ethernet Controllers. Be careful about putting this weapon in
> > the hands of the 'public'. All you need is for one Linux Machine
> > on a LAN to end up with the same IEEE Station Address as another
> > on that LAN and connectivity to everything on that segment will
> > stop. You do this once at an important site and Linux will get a
> > very black eye.
> 
> Can't we already tell cards (some of them anyway) what MAC address to use when
> sending packets?  This doesn't overwrite the EEPROM, but it does last for that
> session...
> 
> Chris

Sure you can. And it was assumed that the MAC address provided by
the manufacturer would always be used by the software for the MAC
address on the wire. However, 'software engineers' have decided
that they don't have to follow the rules, so they provide hooks
so you can use a MAC address of anything.  They even call it
"Local Administration...", which decoded means; "Screw the
committee".

But....
If you ever sell a controller that contains an address that was
not allocated to the 'producer', somebody is going to get very
angry. This means, to me, that if you ever write a new MAC address
to that card/board, you had better throw it away when you are done.

It's easier to make sure that the MAC address doesn't get changed.
You still "screw the comittee" locally, but you don't modify the
hardware.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

