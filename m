Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSKSKva>; Tue, 19 Nov 2002 05:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSKSKva>; Tue, 19 Nov 2002 05:51:30 -0500
Received: from ppp3290-cwdsl.fr.cw.net ([62.210.105.37]:48521 "EHLO
	bouton.inet6-interne.fr") by vger.kernel.org with ESMTP
	id <S265092AbSKSKv3>; Tue, 19 Nov 2002 05:51:29 -0500
Date: Tue, 19 Nov 2002 11:58:25 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Silvio Cesare <silvio@big.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sis650/5513 in 2.4.19 (still broken for 650)
Message-ID: <20021119115825.A4742@bouton.inet6-interne.fr>
Mail-Followup-To: Silvio Cesare <silvio@big.net.au>,
	linux-kernel@vger.kernel.org
References: <20021118222401.GA3777@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021118222401.GA3777@localhost.localdomain>; from silvio@big.net.au on mar, nov 19, 2002 at 09:24:01 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mar, nov 19, 2002 at 09:24:01 +1100, Silvio Cesare wrote:
> Attachment.
> 
> --
> Silvio

> No fixes here.. just reports for anyone interested :(
> 
> 1) sis650/5513 chipset does not work with UDMA - this was reported a while
>    ago, and also reported fixed.. but I don't think its been tested on a
>    sis650 specifically, which (for me) appears still broken (fs
>    corruptions etc).
> 

This is fixed in AC tree.

>    this was reported fixed in 2.4.19; i took a 2.4.18 kernel, and replaced
>    drivers/ide/sis5513.c (theres some includes also, but perhaps not
>    important).  this came up with the same problems as 2.4.18.
>

The driver in 2.4.19-pre broke latest SiS chipsets in DMA modes. Some 650
were affected -> to be safe DMA was disabled for all of them.
Stock 2.4.19 should not fail but only disable DMA, could you confirm this ?

>    2.4.18 incidentally has a function #if 0, at the end of sis5513.c,
>    which I had to make #if 1 (remove) to get a compile (there appears to be
>    no other declaration of this code in the tree) - this has probably
>    been noticed a long time ago I imagine (?).
> 

IIRC this #ifdef is only for compatibility purpose between different IDE
framework versions.

>    for the UDMA issues, recompiling with -->
> 
> #define BROKEN_LEVEL XFER_SW_DMA_0
> 
>    gets it up and running again (ie, without UDMA).
> 
>    incidentally.. the sis 0.13 code by the maintainers have patches
>    against 2.4.18 which break when you run it with #define DEBUG, as
>    some var names have been slightly modified.

?! Could you please try the AC tree with #define DEBUG and report the result
to me ?

> 2) External floppy drive via USB not 100% working..  No idea on this one;
>    I've included very small snippets of bootup messages, but it's no
>    major drama currently (works for the most part), so I don't really
>    expect anyone to look at this (especially with the minimal info
>    I've provided here) :)

Won't be of much help here anyway :-)

> For the sis650, maybe (?) the following will help -->
> [ I've no real clue how useful or non useful this is, but maybe its
>   worth a look for the current development ]

The dump is rather usefull, especially if I know your BIOS config.
Here I assume that each controller is enabled and DMA activated for hda and
hdc, am I right ?

Happy AC compile :-)

LB.
