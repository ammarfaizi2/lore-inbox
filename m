Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKHFCi>; Wed, 8 Nov 2000 00:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKHFC2>; Wed, 8 Nov 2000 00:02:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63247 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129091AbQKHFCY>;
	Wed, 8 Nov 2000 00:02:24 -0500
Message-ID: <3A08DE37.B996A763@mandrakesoft.com>
Date: Wed, 08 Nov 2000 00:01:43 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ivan Passos <lists@cyclades.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Question on new PCI architecture (2.4.x)
In-Reply-To: <Pine.LNX.4.10.10011072049550.7757-100000@main.cyclades.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Passos wrote:
> 
> Hello,
> 
> I was just checking the driver changes needed to comply with the new PCI
> architecture in 2.4.x, and then I got into a problem. I noticed that all
> drivers that use this architecture (or at least the ones I found, such as
> the Tulip, EEPro100, 3c59x ...) support boards with only one net_device
> per board. What about boards with more than one net_device??
> 
> In my case, the driver supports one- and two-channel boards, and I don't
> know how to remove a board that has two net_devices (since
> pdev->driver_data can't contain two pointers!! ;).

pdev->driver_data is only there as a convenience, there is no rule about
one device per board.

In the case of multiple net devices per board, pdev->driver_data would
point to a structure which you allocate, which contains pointers to each
of that board's net devices.


> Also, if anyone could give me pointers to documentation on this new PCI
> architecture (sample src code would be great, real documentation, even
> better!!), I'd really appreciate it.

What questions do you have?

Documentation/pci.txt, include/linux/pci.h, drivers/pci/pci.c, and
various PCI drivers are the only documentation available.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
