Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUHBOMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUHBOMd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbUHBOMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:12:32 -0400
Received: from mail.zmailer.org ([62.78.96.67]:59776 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S266186AbUHBOLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:11:36 -0400
Date: Mon, 2 Aug 2004 17:11:31 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: PATCH: Fix HPT366 crash and support HPT372N
Message-ID: <20040802141131.GA2716@mea-ext.zmailer.org>
References: <20040801001522.GA13954@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801001522.GA13954@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 08:15:22PM -0400, Alan Cox wrote:
> On a board containing the HPT372N IDE controller the 2.6.x series kernels
> will misbehave. If the HPT372N is set up with the newer PCI identifier it
> is ignored. If it is set up with the HPT372 identifier then the kernel
> crashes on boot.

I have been wondering about HPT37x in Fedora Core (development) kernel
called  kernel-smp-2.6.7-1.501.i686.  It doesn't find one of the cards
attached to a HPT372A card that I have.

I tried also to boot with a bit older kernels: 2.6.3, 2.6.5 do work just 
fine (except of 2.6.5 barfs the keyboard..). 

I tried also with 2.6.7-1.494smp (FC devel kernels), and that too
does fail.  I think I had also some a bit older 2.6.7, also that
one failed.   I didn't get around to try any 2.6.6 kernels.

Any ideas ?  Will this patch help ?

  /Matti Aarnio

> This patch is a forward port of my 2.4 driver fixes that have been in 2.4
> for a year but somehow escaped 2.6. Ronny Buchmann caught a couple
> of merge details I missed and those are fixed in this diff too.
> 
> As well as adding 372N support this also fixes the unknown revision case
> to avoid crashes should any future 37x variants with weird class_rev's appear
> 
> Alan
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

> --- linux.vanilla-2.6.8-rc2/drivers/ide/pci/hpt366.c	2004-07-27 19:22:42.000000000 +0100
> +++ linux-2.6.8-rc2/drivers/ide/pci/hpt366.c	2004-08-01 00:58:30.948290640 +0100
....
