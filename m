Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273644AbRJBNFN>; Tue, 2 Oct 2001 09:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273648AbRJBNFC>; Tue, 2 Oct 2001 09:05:02 -0400
Received: from dreams.vianet.on.ca ([209.91.128.20]:54253 "EHLO
	dreams.vianet.on.ca") by vger.kernel.org with ESMTP
	id <S273644AbRJBNEu>; Tue, 2 Oct 2001 09:04:50 -0400
Message-ID: <005101c14b42$d180d2d0$5764a8c0@tdnlaptop>
From: "mofo" <mofo@thirddimension.net>
To: <linux-kernel@vger.kernel.org>
Subject: [2.4.10] Possible bug:  Xircom Tulip PCMCIA (new and old driver) DHCP failure
Date: Tue, 2 Oct 2001 09:04:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed the following problem when attempting to use either the new or
old Xircom Tulip PCMCIA driver and DHCP.

The system will attempt to obtain an address (dhclient) and seem to be
successful, but it doesn't not show an address bound to the NIC in 'ifconfig
eth0'.  No TCP/IP traffic can be sent or received as well.  If I installed
the driver(s) into the kernel or as a module, the effect is the same.

Now if I enable the 'Use 10/100 PCI/ISA Ethernet Cards' (menuconfig, sorry
don't know the CONFIG_XX_XX .config file alternative) in 'Network Devices'
and remove any default cards selected, recompile, and reboot.  The card will
now show the bound IP address and TCP/IP will work fine.

Is this normal that the 'Use 10/100 PCI/ISA Ethernet Cards' must be selected
for DHCP to work?

Here's the testing I'm going to attempt tonight after work:

-static IP addressing
-seeing if the DHCP server sees a request when the client thinks it has no
IP address.

Thanks much,

-reid

Card: Xircom 10/100 56k Cardbus (exact model unknown, works with either new
or old driver)
Kernel: 2.4.10 with ext3 patched in
DHCP Client: dhclient-2.2.x from the ISC



