Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286712AbSASPaS>; Sat, 19 Jan 2002 10:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286750AbSASPaI>; Sat, 19 Jan 2002 10:30:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286712AbSASP37>;
	Sat, 19 Jan 2002 10:29:59 -0500
Message-ID: <3C4990F4.EF7A5B13@mandrakesoft.com>
Date: Sat, 19 Jan 2002 10:29:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Rompf <srompf@isg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Rompf wrote:
> So what about the following idea: The network interface drivers use the
> netif_carrier_on() and netif_carrier_off() functions to update their
> interface card status (a bunch of drivers already do). To get this
> information forwarded to user mode via netlink socket, we use a kernel
> thread that goes through the device list, and everytime IFF_RUNNING
> and netif_carrier_ok() differ, IFF_RUNNING is updated and a message is
> sent via netlink.

In fact, that's the 2.5 plan -- send link up/down notifications via
netlink.  If you provide a patch, more the better.

For 2.4, you'll need to poll ETHTOOL_GLINK, assuming that the driver
supports ethtool.

In any case, your tulip patch looks pretty good on first review.  I'll
likely apply it to 2.4 and 2.5 after testing and further review.

	Jeff



-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
