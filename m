Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSDORaj>; Mon, 15 Apr 2002 13:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSDORai>; Mon, 15 Apr 2002 13:30:38 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:31248 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313014AbSDORah>; Mon, 15 Apr 2002 13:30:37 -0400
Message-ID: <3CBB0E39.F226E585@linux-m68k.org>
Date: Mon, 15 Apr 2002 19:30:33 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
In-Reply-To: <20020415070728.GB12608@suse.de> <Pine.LNX.4.21.0204151334350.26237-100000@serv> <20020415115131.GN12608@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jens Axboe wrote:

> > That's not enough, some archs don't define pci_alloc_consistent/
> > pci_free_consistent, because they have neither PCI nor ISA.
> 
> Please, then those archs need to provide similar functionality. This is
> the established api, unless you want to change the documentation and xxx
> number of drivers?

Anyway, could this part be moved to ide-dma.c or disabled with
CONFIG_BLK_DEV_IDEDMA_PCI, as it only seems to be used in ide-dma.c. Why
allocating this memory, when it's never used in PIO mode?

bye, Roman
