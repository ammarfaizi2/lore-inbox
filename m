Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272295AbRH3Pwk>; Thu, 30 Aug 2001 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272293AbRH3PwU>; Thu, 30 Aug 2001 11:52:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54032 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272291AbRH3PwO>; Thu, 30 Aug 2001 11:52:14 -0400
Subject: Re: A possible direction for the next LVM driver
To: thornber@btconnect.com (Joe Thornber)
Date: Thu, 30 Aug 2001 16:55:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010830164547.A807@btconnect.com> from "Joe Thornber" at Aug 30, 2001 04:45:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cUAe-0001IO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When the logical device is accessed, the make_request function looks
> up the correct target for the given sector, and then asks this target
> to do the remapping.

Interesting.

> A btree structure is used to hold the sector range -> target mapping.
> Since we know all the entries in the btree in advance we can make a
> very compact tree, omitting pointers to child nodes, (child nodes
> locations can be calculated).  Typical users would find they only have
> a handful of targets for each logical volume LV.
> Benchmarking with bonnie++ suggests that this is certainly no slower
> than current LVM.

Will it represent single segment filesystems as one node (ie extremely
efficiently). The reason I ask is that one thing EVMS does that I think is
right is that it lets you throw away the whole partitioning business.
Instead  DOS partition format, BSD disklabel etc are simply very limited
logical volumes

