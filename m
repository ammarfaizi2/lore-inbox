Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318979AbSICVxs>; Tue, 3 Sep 2002 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSICVxs>; Tue, 3 Sep 2002 17:53:48 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:39152
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318979AbSICVxr>; Tue, 3 Sep 2002 17:53:47 -0400
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Hacksaw <hacksaw@hacksaw.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209031448000.3373-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209031448000.3373-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 03 Sep 2002 22:59:58 +0100
Message-Id: <1031090398.21439.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 21:55, Thunder from the hill wrote:
> And if you meant why not use journaled partition updates on raid -- I 
> still don't see how this could be any good without complicating things. 
> Maybe you can enlighten me?

If you have a good raid card then you can do online resizing, volume
allocation, volume format changing, volume migration etc. For those
cases you have to get the journalling right in order to be able to do
that kind of thing properly

> LVM2 is not the kind of thing I'd want to use on my big bad mainframe. It 
> may be feasible, but it doesn't have that smell. And where to plug all 
> those disks?

Standard PC with 80Gb disks benefits from dynamic partitioning. But if
you are pushed then you can shove 3ware 8500 PCI cards into your slots
and get 12 SATA hotplug IDE channels per PCI slot.

Thats 12 * 200Gb hotswap per pci slot. Which given 4 slots of it would
come out at a nice 9600Gb of disk. Maybe you can archive usenet on one
PC after all 8)

Alan

