Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131696AbQLGAhT>; Wed, 6 Dec 2000 19:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLGAhK>; Wed, 6 Dec 2000 19:37:10 -0500
Received: from smtp.lax.megapath.net ([216.34.237.2]:35844 "EHLO
	smtp.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S131696AbQLGAhG>; Wed, 6 Dec 2000 19:37:06 -0500
Message-ID: <3A2ED42C.9050304@megapathdsl.net>
Date: Wed, 06 Dec 2000 16:05:00 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12 i686; en-US; m18) Gecko/20001202
X-Accept-Language: en
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jerdfelt@valinux.com, usb@in.tum.de
Subject: Re: test12-pre6
In-Reply-To: <20001206200803.C847@arthur.ubicom.tudelft.nl> <Pine.LNX.4.10.10012061131320.1873-100000@penguin.transmeta.com> <20001206210928.G847@arthur.ubicom.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

> On Wed, Dec 06, 2000 at 11:38:30AM -0800, Linus Torvalds wrote:
> 
>> But I see something obviously wrong there: you have busmaster disabled.
>> 
>> Looking into the UHCI controller code, I notice that neither UHCI driver
>> actually does the (required)
>> 
>> 	pci_set_master(dev);
>> 
>> Please add that to just after a successful "pci_enable_device(dev)", and I
>> just bet your USB will start working.


I tested this change applied to usb-ohci.
I did not fix the problem where eth0 spits
out a ton of error messages:

eth0: Host error, FIFO diagnostic register 0000.
eth0: using default media MII
eth0: Host error, FIFO diagnostic register 0000.
eth0: using default media MII
eth0: Too much work in interrupt, status e003.
eth0: Host error, FIFO diagnostic register 0000.
eth0: using default media MII

This error occurs when I am trasfering data over my
DSL connection while moving my USB mouse.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
