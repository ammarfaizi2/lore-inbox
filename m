Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbREVVFh>; Tue, 22 May 2001 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbREVVF1>; Tue, 22 May 2001 17:05:27 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:6148 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S262824AbREVVFJ>;
	Tue, 22 May 2001 17:05:09 -0400
Message-ID: <20010522151143.A9541@bug.ucw.cz>
Date: Tue, 22 May 2001 15:11:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
In-Reply-To: <20010519231131.A2840@jurassic.park.msu.ru> <20010520044013.A18119@athlon.random> <3B07AF49.5A85205F@uow.edu.au> <20010520154958.E18119@athlon.random> <20010520181803.I18119@athlon.random> <3B07EEFE.43DDBA5C@uow.edu.au> <20010520184411.K18119@athlon.random> <3B07F6B8.4EAB0142@uow.edu.au> <20010520191206.A30738@athlon.random> <15112.27206.4123.40450@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <15112.27206.4123.40450@pizda.ninka.net>; from David S. Miller on Sun, May 20, 2001 at 06:07:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > [..]  Even sparc64's fancy
>  > > iommu-based pci_map_single() always succeeds.
>  > 
>  > Whatever sparc64 does to hide the driver bugs you can break it if you
>  > pci_map 4G+1 bytes of phyical memory.
> 
> Which is an utterly stupid thing to do.
> 
> Please construct a plausable situation where this would occur legally
> and not be a driver bug, given the maximum number of PCI busses and
> slots found on sparc64 and the maximum _concurrent_ usage of PCI dma
> space for any given driver (which isn't doing something stupid).

What stops you from plugging PCI-to-PCI bridges in order to create
some large number of slots, like 128?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
