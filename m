Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSAPSD4>; Wed, 16 Jan 2002 13:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSAPSDu>; Wed, 16 Jan 2002 13:03:50 -0500
Received: from mail-2.addcom.de ([62.96.128.36]:53259 "HELO mail-2.addcom.de")
	by vger.kernel.org with SMTP id <S284717AbSAPSCq>;
	Wed, 16 Jan 2002 13:02:46 -0500
Date: Wed, 16 Jan 2002 16:51:24 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Russell King <rmk@arm.linux.org.uk>
cc: Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Autoconfiguration: Original design scenario
In-Reply-To: <20020115105733.B994@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0201161648360.8029-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Russell King wrote:

> There weren't many clues on the card packaging what it was, and couldn't
> find anything on the net about the card, so resourted to the "insmod this
> module, does it do anything" approach.  After many hours of prodding
> around and reading source, turns out that it needed the hisax driver with
> various random parameters.
> 
> I really don't see why hisax couldn't say "oh, you have an ISDN card with
> IDs xxxx:xxxx, that's hisax type nn" and be done with it, rather than
> needing to be told "pci id xxxx:xxxx type nn".  Have a look at
> drivers/isdn/hisax/config.c and wonder how the hell you take some random
> vendors PCI ISDN card and work out how to drive it under Linux.

The fact that hisax needs command line parameters even for PCI cards only 
has historical reasons. In 2.5 this is scheduled to change, such that an 
insmod automatically will do the right thing. It will remain as-is in 2.4 
for compatibility reasons.

--Kai




