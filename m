Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTBCWfs>; Mon, 3 Feb 2003 17:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBCWfr>; Mon, 3 Feb 2003 17:35:47 -0500
Received: from salud.unm.edu ([129.24.128.127]:26897 "EHLO salud.unm.edu")
	by vger.kernel.org with ESMTP id <S267039AbTBCWf0>;
	Mon, 3 Feb 2003 17:35:26 -0500
Message-Id: <se3e8e6f.060@salud.unm.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.3 Beta
Date: Mon, 03 Feb 2003 15:44:20 -0700
From: "Cameron Goble" <cgoble@salud.unm.edu>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: SIS900 module detects two transceivers, picks the wrong
	one
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> "Richard B. Johnson" root@chaos.analogic.com> 02/03/03 03:12PM >>

Thanks for the quick response, Richard!
 
> Perhaps dmesg will explain better:
> 
> eth0: AMD79C901 HomePNA PHY transceiver found at address 2.
> eth0: AMD79C901 10BASE-T PHY transceiver found at address 3.
> eth0: using transceiver found at address 2 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xec400, IRQ 11,
00:30:67:09:53:81.

>This looks as though your wire is just connected backwards, i.e.,
>you have a reversed patch-cord.

The patch cable I've got has worked on other machines and hub set up
for 10Base-T.
 
>Are you connected to a Hub? Does the LED on the hub show that
>the wire is connected properly an does the LED on/near the connector
on
>your PC show that its connected correctly also?
 
Both the hub and the PC show link lights when connected, yes. The hub
is 10Base-T also.

>If you really do have to such connectors, just use eth1 instead of
>eth0, i.e., `ifconfig eth1 ip-address ...`

I will certainly give this a try. It's turning out to be quite an
experience in how the Linux kernel thinks of devices. :) I don't really
care which eth port it uses, as long as it works. 
 
So my ifconfig would be:
ifconfig eth1 address 192.168.0.4  netmask 255.255.255.0 
- right?
 
I'm curious though - does ipconfig actually *create* the device ethx?
Isn't that what the SIS900 module is doing -- detecting a device and
mapping it onto eth0? dmesg does not reveal a similar report for eth1.
In that case, how do I force it to use the transceiver at address 3 (see
the dmesg above), or will it decide to use that one automatically? Sorry
for my ignorance.

Thanks very much,
Cameron Goble



