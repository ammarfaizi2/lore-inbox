Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSGMOAc>; Sat, 13 Jul 2002 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSGMOAc>; Sat, 13 Jul 2002 10:00:32 -0400
Received: from 62-190-217-195.pdu.pipex.net ([62.190.217.195]:9477 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S313571AbSGMOAb>; Sat, 13 Jul 2002 10:00:31 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207131407.PAA00242@darkstar.example.net>
Subject: Re: IDE/ATAPI in 2.5
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sat, 13 Jul 2002 15:07:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, thunder@ngforever.de, schilling@fokus.gmd.de
In-Reply-To: <1026570328.9958.83.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jul 13, 2002 03:25:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Because we can't tell Linux users "your (once favorite) CD-ROM is not 
> > > implemented in Linux (any more), and will never ever be". If we explicitly 
> > > exclude hardware, where do we end?!
> > 
> > Like other mainstream operating systems :-)
> > 
> > One thing that occurs to me, but that I don't necessarily think is a good idea,
> > is that for a long time we had "old" IDE code and "new" IDE code in the kernel,
> > and there is no reason why we couldn't do a similar thing, (I.E. have
> > a "legacy devices will work" foo driver, and "legacy devices might 
> 
> So we'd have a legacy driver called oh say 'ide-cd' and a current one
> called 'ide-scsi'.
> 
> How does that change anything ?

Both of the existing drivers would become the legacy driver, and a new one would be forked from the legacy code, which abstracts the physical interface altogether.  Eventually, we're going to have IDE, ATAPI (I.E. mostly non-disk IDE devices), SCSI, SASI(maybe :-)), USB, FireWire, Bluetooth, etc.  The number of interfaces is just going to grow and grow.
