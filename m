Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSDUKUc>; Sun, 21 Apr 2002 06:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313307AbSDUKUb>; Sun, 21 Apr 2002 06:20:31 -0400
Received: from fungus.teststation.com ([212.32.186.211]:38925 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313304AbSDUKUa>; Sun, 21 Apr 2002 06:20:30 -0400
Date: Sun, 21 Apr 2002 12:19:40 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: "Ivan G." <ivangurdiev@yahoo.com>
cc: Shing Chuang <ShingChuang@via.com.tw>, LKML <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] Via-rhine minor issues
In-Reply-To: <02042101022001.00833@cobra.linux>
Message-ID: <Pine.LNX.4.33.0204211151010.13036-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002, Ivan G. wrote:

> DIFF-ED AGAINST:
> 2.4.19-pre3 ( I don't think there were changes to via-rhine 
> b-ween pre3 and pre7)

You should probably send this to Jeff Garzik instead of Marcelo. Jeff
collects net driver patches.

If you don't, Shing Chuang's changes are in -pre7-ac2, so a re-diff vs
that and seding it to Alan Cox may cause less merge work.


> - changed chip_id in wait_for_reset as parameter since np is not initialized
> the first time this function is called (should this be fixed differently?)

I think that is an ok change. np could be initialised sooner instead but
I don't know why that would be better.

> - change "Something Wicked" message to "PCI Error" (I still don't see the 
> purpose of the trap)

To trap things ... :)

Maybe there should be a trap for all the unhandled interrupt status error
events. via_rhine_interrupt could list more Intr flags as reasons to call
via_rhine_error, if you know which ones are errors.

/Urban

