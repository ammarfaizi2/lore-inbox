Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbSLaSME>; Tue, 31 Dec 2002 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264649AbSLaSME>; Tue, 31 Dec 2002 13:12:04 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:33715 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264631AbSLaSMD>; Tue, 31 Dec 2002 13:12:03 -0500
Date: Tue, 31 Dec 2002 13:19:42 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: networking for linux PDAs
Message-ID: <Pine.LNX.4.44.0212311314550.2126-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  from some recent postings on a sharp zaurus related list
(and some experimentation on my part with my zaurus 5500),
there's a small problem with networking via USB hotplug
to a Z in its cradle.

  when one plugs in the Z to the USB port, here's what i 
get in /var/log/messages

Dec 31 12:39:19 dell kernel: hub.c: new USB device 00:1f.2-1, assigned address 6
Dec 31 12:39:19 dell kernel: CDCEther.c: eth1: Sharp SL Series 
Dec 31 12:39:19 dell /etc/hotplug/net.agent: invoke ifup eth1
Dec 31 12:39:22 dell /etc/hotplug/usb.agent: Setup acm CDCEther usbnet for USB product 4dd/8004/0

  this is not correct, since this is activating the net interface
eth1, rather than usb0, the correct interface.

  apparently, the problem is that the CDCEther module is, as
someone pointed out to me, getting in the way.  one proposed
solution is to add CDCEther to /etc/hotplug/blacklist.

  in any case, what is the preferred way around this?  clearly, 
there seems to be conflict between CDCEther.o and usbnet.o,
at least in this case.

  thoughts?

rday

