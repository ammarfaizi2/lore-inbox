Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUJIAfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUJIAfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 20:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUJIAfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 20:35:18 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:10423 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266333AbUJIAfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 20:35:12 -0400
Message-ID: <58cb370e04100817353254b8cd@mail.gmail.com>
Date: Sat, 9 Oct 2004 02:35:11 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Subject: Re: Problem with ide=nodma
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0410090019150.26458@ppg_penguin.kenmoffat.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410090019150.26458@ppg_penguin.kenmoffat.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2004 00:32:01 +0100 (BST), Ken Moffat
<ken@kenmoffat.uklinux.net> wrote:
> Hi,
> 
>  I'm trying a sii 0680 disk controller at the moment, as a possible
> workaround for some via southbridge problems (this is on a ppc which
> isn't yet supported by the official kernels, but it has been stable here
> since 2.6.7 and looks nearly ready for a first review).  Unfortunately,
> DMA is a big no go at the moment so I have to pass ide=nodma in the
> bootargs.
> 
>  I've got the drives plugged into the sii card, and ide=reverse is doing
> its job.  But although dmesg shows that dma has been turned off,

Is it possible that you are reading it wrong?

> /proc/ide/hda/settings and hdparm show that dma is in use.  This is in
> 2.6.9-rc3.
> 
>  Doesn't ide=nodma work for off-board chipsets ?

siimage host driver doesn't respect "ide=nodma".
You can hack siimage.c and comment out "hwif->autodma = 1".
