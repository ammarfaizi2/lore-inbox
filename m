Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273801AbRI0Sap>; Thu, 27 Sep 2001 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273802AbRI0Saf>; Thu, 27 Sep 2001 14:30:35 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:24448 "EHLO ookhoi.xs4all.nl")
	by vger.kernel.org with ESMTP id <S273801AbRI0Sa1>;
	Thu, 27 Sep 2001 14:30:27 -0400
Date: Thu, 27 Sep 2001 20:30:53 +0200
From: Ookhoi <ookhoi@dds.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] netconsole - log kernel messages over the network. 2.4.10.
Message-ID: <20010927203053.J774@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010927171818.H774@humilis> <3BB36A6A.B0736CA2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB36A6A.B0736CA2@zip.com.au>
User-Agent: Mutt/1.3.19i
X-Uptime: 20:46:40 up 5 min,  5 users,  load average: 1.80, 0.73, 0.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> > Ingo was not aware of the sourceforge project, and suggested me to
> > resend my reply to lkml. Does the patch work for you guys? Do I do
> > something wrong? That would be more than possible. :-)
> > 
> > ...
> > cuddle:~# uname -a
> > Linux cuddle 2.4.9-ac15 #1 Thu Sep 27 13:54:51 CEST 2001 i686 unknown
> > cuddle:~# insmod netconsole dev=eth0 target_ip=0x0a604875 source_port=6666 target_port=5555
> > Using /lib/modules/2.4.9-ac15/kernel/drivers/net/netconsole.o
> > /lib/modules/2.4.9-ac15/kernel/drivers/net/netconsole.o: init_module: Operation not permitted
> > Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
> 
> If you're not using the eepro100 driver, then an insmod of the
> netconsole driver will fail:
> 
> 
> +       if (!ndev->poll_controller) {
> +               printk(KERN_ERR "netconsole: %s's network driver does not implement netlogging yet, aborting.\n", dev);
> +               return -1;
> +       }
> 
> Maybe that message is in your logs somewhere?

Have to check that, can't reach the machine atm. But I don't use the
eepro100 driver for sure in that machine, so the insmod failure makes
sense. :-)

> Take a look at the poll_controller() implementation in the eepro100
> part of Ingo's patch - it's dead simple.

I believe you ;-)  but I'm affraid I'm just a user, no programmer at
all :-(

> What we need is for a bunch of people to implement poll_controller()
> for *their* ethernet driver and contribute the tested diffs back to
> Ingo.

Would love to contribute.. Anyway, thank you for your answer!

	Ookhoi
