Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSKJBy4>; Sat, 9 Nov 2002 20:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262933AbSKJBy4>; Sat, 9 Nov 2002 20:54:56 -0500
Received: from host194.steeleye.com ([66.206.164.34]:17413 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262884AbSKJByz>; Sat, 9 Nov 2002 20:54:55 -0500
Message-Id: <200211100201.gAA21Uv04824@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: James.Bottomley@SteelEye.com, andmike@us.ibm.com, greg@kroah.com,
       hch@lst.de, linux-kernel@vger.kernel.org, mochel@osdl.org,
       parisc-linux@lists.parisc-linux.org, willy@debian.org
Subject: Re: [parisc-linux] Untested port of parisc_device to generic device 
 interface
In-Reply-To: Message from "Adam J. Richter" <adam@yggdrasil.com> 
   of "Sat, 09 Nov 2002 16:23:59 PST." <200211100023.QAA27139@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Nov 2002 21:01:29 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

adam@yggdrasil.com said:
> 
> 	I'd like to know more about what these machines look like in the real
> world.  Specifically, I am interested in the trade-off of having a
> parameter to wback_fake_consistent so that it could be enabled or
> disabled on an individual basis.

Actually, so would I.  I can suspect why there might exist machines like this 
(say the consistent attribute is settable at the pgd level)

> 	I suspect that the parameter is not worth the clutter because these
> "partially consistent" machines either have a large amount of
> consistent memory, so the case of the allocation failing in the is not
> worth supporting, or it is easy to check for consistent memory on them
> with something like "if ((unsigned long) vaddr < 0xwhatever)", but I'm
> just guessing. 

Well, if it has to be done, it can be done by making alloc_consistent return a 
handle rather than an address and making wback/invalidate take the handle (but 
it's certainly not ideal).

James


