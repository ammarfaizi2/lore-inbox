Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUH2Alc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUH2Alc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUH2Alc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:41:32 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:27936 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S268148AbUH2AlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:41:05 -0400
Date: Sun, 29 Aug 2004 02:41:03 +0200 (CEST)
From: Wouter Van Hemel <wouter-kernel@fort-knox.rave.org>
To: Jeremy <jeremy@felonyroom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PWC driver changes
In-Reply-To: <loom.20040829T011815-40@post.gmane.org>
Message-ID: <Pine.LNX.4.61.0408290214030.569@senta.theria.org>
References: <loom.20040829T011815-40@post.gmane.org>
PGP: 0B B4 BC 28 53 62 FE 94  6A 57 EE B8 A6 E2 1B E4  (0xAA5412F0)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Jeremy wrote:

> This whole affair is especially disappointing for me, as I just got a Phillips
> webcam up and running the other day using pwcx.

I received mine just one day too late... And I guess I'm not the only one. 
The fact that I bought it especially because of Linux support after trying 
3 other cams last week, adds some irony to ease the bitterness. :)

>  Will some kind soul please
> post something indicating which files contained the hook?  Was it part of pwc
> somewhere?

Yes. I assume it's all the stuff that contains the word 'decompressor'. 
Such as:

-       pdev->decompressor = NULL;
+       /* Find our decompressor, if any */
+       pdev->decompressor = pwc_find_decompressor(pdev->type);

You can easily do a diff between the previous kernel version and a more 
recent one without the hooks.

Here's the patch that removed the whole driver:
http://linux.bkbits.net:8080/linux-2.6/gnupatch@412d8e0cqutBsdGubqorXXCeHHdS2g

You can reverse-patch this and then do a diff compare between the tree and 
the pwc-9.0.2 package. Or find the patchset that removed the hook.

A quick look with diff shows changes in:
./pwc-ctrl.c
./pwc-if.c
./pwc-uncompress.h
./pwc.h

>  I'd like to compare the older kernel sources I have to the 2.6.8 I
> just downloaded so I can see what I need to change in order to keep pwcx
> working.
>

Do email Philips customer support though. Let them know you use linux, 
bought their product and want a driver.

