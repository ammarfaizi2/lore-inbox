Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbRETQ7C>; Sun, 20 May 2001 12:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262086AbRETQ6w>; Sun, 20 May 2001 12:58:52 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:29901 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S262085AbRETQ6l>; Sun, 20 May 2001 12:58:41 -0400
Message-ID: <3B07F6B8.4EAB0142@uow.edu.au>
Date: Mon, 21 May 2001 02:54:16 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010518214617.A701@jurassic.park.msu.ru> <20010519155502.A16482@athlon.random> <20010519231131.A2840@jurassic.park.msu.ru>, <20010519231131.A2840@jurassic.park.msu.ru>; <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random>, <20010520154958.E18119@athlon.random>; <20010520181803.I18119@athlon.random> <3B07EEFE.43DDBA5C@uow.edu.au>,
		<3B07EEFE.43DDBA5C@uow.edu.au>; from andrewm@uow.edu.au on Mon, May 21, 2001 at 02:21:18AM +1000 <20010520184411.K18119@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > I can't find *any* pci_map_single() in the 2.4.4-ac9 tree
> > which can fail, BTW.
> 
> I assume you mean that no one single caller of pci_map_single is
> checking if it failed or not (because all pci_map_single can fail).

No.  Most of the pci_map_single() implementations just
use virt_to_bus()/virt_to_phys().  Even sparc64's fancy
iommu-based pci_map_single() always succeeds.
