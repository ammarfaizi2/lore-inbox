Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271309AbRHUCbD>; Mon, 20 Aug 2001 22:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271330AbRHUCax>; Mon, 20 Aug 2001 22:30:53 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:56981 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S271309AbRHUCan>; Mon, 20 Aug 2001 22:30:43 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 20 Aug 2001 19:30:49 -0700
Message-Id: <200108210230.TAA24661@adam.yggdrasil.com>
To: atm@enterzone.net
Subject: Re: [Linux-ATM-General] PATCH: linux-2.4.9/drivers/atm to new module_{init,exit} + some pci_device_id tables
Cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: John Fraizer <atm@EnterZone.Net>
>Just a quick question.  Please be gentl.  I'm not a kernel hack.  I just
>want to make sure that it will still be possible to build a monolythic
>kernel with ATM support.  If not, that is a BAD thing.  

	Yes, you still can.  module_{init,exit} are defined in
the monolithic case to add the initialization routine to a list
of initializers that the kernel calls in do_initcalls
(in linux/init/main.c), and to compile the module_exit call
into nothing.  This way, you can have a driver that is written
like a module but actually supports both the modular and monolithic
cases without need for #ifdef's and different code for the two cases.
That is the primary point of the module_{init,exit} scheme.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
