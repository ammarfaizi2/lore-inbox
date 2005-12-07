Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVLGVfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVLGVfx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbVLGVfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:35:53 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:28947 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751795AbVLGVfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:35:52 -0500
Date: Wed, 7 Dec 2005 22:35:47 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Conio sandiago <coniodiago@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Urgent work ! please help
Message-ID: <20051207213547.GA15993@alpha.home.local>
References: <993d182d0512070225kbc4d926w5ab4255e4cdaea75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993d182d0512070225kbc4d926w5ab4255e4cdaea75@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 03:55:32PM +0530, Conio sandiago wrote:
> Hi all
> i am conio,
> i am facing some problems.
> I have a embedded monta vista linux kernel running on arm processor,
> the linux kernel version is 2.6.x

First rule if you're looking for some help : be precise. 2.6.x is not
a kernel version, and ARM is more a family than a processor.

> I have developed a ethernet driver for the same.

>From your report below, I think that you now need to add some debug
code to your driver. It seems reasonable that a new development is
buggy at first, and a broken ethernet driver can easily lead to
corrupted data.

> But now i am facing a strange problems-
> 
> 1) If i do a ftp for a very big file from one board to another pc
> using a switching hub then

what size ? what speed ? half/full duplex ? what transfer speed do
you observe before the problem ?

> At an early stage ftp-data is normally sent to LinuxPC. Then suddenly
> the embedded linux  asks the IP address of LinuxPC with using ARP.

it may simply mean that it has lost access to the other one and that
the ARP cache has expired.

> After this point it start taking a lot of time to transfer data with
> ftp command.
> 
> The packet analysis  shows there are  errors ,"TCP CHECKSUM INCORRECT".

before asking, have you tried :
  - change your switch and connect with a cross-over cable
  - sending icmp, udp
  - transfer in each direction separately to check whether it happens
    on transmit / receive / both
  - reduce MTU on one, then the other, then both ends
  - ping during the transfer

?

> Please help
> if somebody has some idea
> whether it can be a hardware / software bug???

with so few information, it's hard to say. At most, we can deduce that
you encountered a problem the first time you tried your fresh new driver.

> Regards
> conio

Regards,
Willy

