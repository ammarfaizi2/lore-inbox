Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbREUJZK>; Mon, 21 May 2001 05:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbREUJZB>; Mon, 21 May 2001 05:25:01 -0400
Received: from ns.suse.de ([213.95.15.193]:15624 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262415AbREUJYv>;
	Mon, 21 May 2001 05:24:51 -0400
Date: Mon, 21 May 2001 11:23:57 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010521112357.A1718@gruyere.muc.suse.de>
In-Reply-To: <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <3B07CF20.2ABB5468@uow.edu.au> <20010520163323.G18119@athlon.random> <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15112.55709.565823.676709@pizda.ninka.net>; from davem@redhat.com on Mon, May 21, 2001 at 02:02:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the topic of to the PCI DMA code: one thing I'm missing
are pci_map_single()/pci_map_sg() that take struct page * instead of
of direct pointers. Currently I don't see how you would implement IO-MMU IO
on a 32bit box with more than 4GB of memory, because the address won't
fit into the pointer.

-Andi
