Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272178AbRHWBji>; Wed, 22 Aug 2001 21:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272179AbRHWBja>; Wed, 22 Aug 2001 21:39:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59010 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272178AbRHWBjO>;
	Wed, 22 Aug 2001 21:39:14 -0400
Date: Wed, 22 Aug 2001 18:39:12 -0700 (PDT)
Message-Id: <20010822.183912.61335222.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108230132.f7N1WkY22194@aslan.scsiguy.com>
In-Reply-To: <20010822.180858.89278064.davem@redhat.com>
	<200108230132.f7N1WkY22194@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 19:32:46 -0600

   Perhaps its different for SBUS, but its not different for ISA
   or EISA.

Right, you pass in a NULL pci_dev pointer.  What is the
problem with that?

   Do you believe that it is architecturally correct to have a single
   api or multiple apis?

I think just plain different entry points are the way to do things,
because function pointers and/or extra conditional execution rots when
it's really not needed.

   The "pci" api already allows you to express this.

There will be a "struct device" in 2.5.x and lots of unification.

Frankly, I'd rather not touch the SBUS drivers though.
All the devices are cast in stone, I'm the only person
who maintains or even works on any of the drivers, and
the less I have to change at this point the better.

Later,
David S. Miller
davem@redhat.com

