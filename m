Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSDOMJc>; Mon, 15 Apr 2002 08:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312563AbSDOMJb>; Mon, 15 Apr 2002 08:09:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61191 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312526AbSDOMJb>;
	Mon, 15 Apr 2002 08:09:31 -0400
Date: Mon, 15 Apr 2002 14:09:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
Message-ID: <20020415120927.GO12608@suse.de>
In-Reply-To: <20020415115131.GN12608@suse.de> <Pine.LNX.4.21.0204151356070.26237-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Roman Zippel wrote:
> Hi,
> 
> On Mon, 15 Apr 2002, Jens Axboe wrote:
> 
> > > That's not enough, some archs don't define pci_alloc_consistent/
> > > pci_free_consistent, because they have neither PCI nor ISA.
> > 
> > Please, then those archs need to provide similar functionality. This is
> > the established api, unless you want to change the documentation and xxx
> > number of drivers?
> 
> These functions are only specified for PCI/ISA and there was no need so

In my mind these are generic functions, it's a shame that they come with
a pci_ prefix and take a pci dev as first argument (the NULL for isa
seems like a kludge).

> far to implement them. It's no problem to provide the functionality, but I
> have to know with what API.

Should be very easy for you to provide similar functionality for m68k,
just take a look at the x86 functions.

-- 
Jens Axboe

