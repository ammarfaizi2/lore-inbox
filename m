Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbRETRQx>; Sun, 20 May 2001 13:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262099AbRETRQo>; Sun, 20 May 2001 13:16:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41651 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262100AbRETRQb>;
	Sun, 20 May 2001 13:16:31 -0400
Message-ID: <3B07FBE9.1176D9DC@mandrakesoft.com>
Date: Sun, 20 May 2001 13:16:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <20010520181803.I18119@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, May 20, 2001 at 03:49:58PM +0200, Andrea Arcangeli wrote:
> > they returned zero. You either have to drop the skb or to try again later
> > if they returns zero.
> 
> BTW, pci_map_single is not a nice interface, it cannot return bus
> address 0, 

who says?

A value of zero for the mapping is certainly an acceptable value, and it
should be handled by drivers.

In fact its an open bug in a couple net drivers that they check the
mapping to see if it is non-zero...

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
