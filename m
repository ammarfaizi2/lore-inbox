Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLGPIq>; Thu, 7 Dec 2000 10:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQLGPIg>; Thu, 7 Dec 2000 10:08:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129406AbQLGPIY>; Thu, 7 Dec 2000 10:08:24 -0500
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 7 Dec 2000 14:40:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        khc@intrepid.pm.waw.pl (Krzysztof Halasa),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A2F9AD4.830153B4@mandrakesoft.com> from "Jeff Garzik" at Dec 07, 2000 09:12:36 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1442DQ-0002VT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >                         struct hdlc_protocol
> >                         struct fr_protocol
> >                         struct eth_physical
> 
> Not yet another one for eth...  We now have ethtool for this.  And a
> generic netdevice::set_config wrapper can be created that simply calls
> the ethtool ioctl with the proper info and locking.

There I disagree. I would do it the other way up. Post 2.4 you make the
ethtool ioctl simply build an eth_physical and run in that way. Right now
the ethtool stuff is a bit hackish and cannot handle upcoming real world
situations such as setting the cryptokey for onboard crypto on ethernet
cards, or handling devices that present themselves as ethernet but are not
at the physical layer being remotely honest about it.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
