Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLRTei>; Mon, 18 Dec 2000 14:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQLRTe3>; Mon, 18 Dec 2000 14:34:29 -0500
Received: from [216.101.162.242] ([216.101.162.242]:7585 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129525AbQLRTeN>;
	Mon, 18 Dec 2000 14:34:13 -0500
Date: Mon, 18 Dec 2000 10:44:14 -0800
Message-Id: <200012181844.KAA05718@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1001218135307.5234A-100000@chaos.analogic.com>
	(root@chaos.analogic.com)
Subject: Re: VM performance problem
In-Reply-To: <Pine.LNX.3.95.1001218135307.5234A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Mon, 18 Dec 2000 13:54:56 -0500 (EST)
   From: "Richard B. Johnson" <root@chaos.analogic.com>

   6/	Deallocates all the buffers by running down the linked-list.

 ...

   If the program deallocates all the buffers, as in (6) above, it will
   take even up to 1 whole minute!! At this time, there is an enormous
   amount of swap-file activity going on.

How exactly are these buffers allocated/deallocated?  Are you
absolutely certain that the deallocation process does not make loads
from or stores into the buffers as a free(3) implementation would?

That would cause the pages to be sucked back from swap space.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
