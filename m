Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVEEPiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVEEPiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVEEPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 11:38:50 -0400
Received: from animx.eu.org ([216.98.75.249]:6539 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262016AbVEEPir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 11:38:47 -0400
Date: Thu, 5 May 2005 11:38:07 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/ide/hd?/settings obsolete in 2.6.
Message-ID: <20050505153807.GB17724@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050505004854.GA16550@animx.eu.org> <58cb370e050505031041c2c164@mail.gmail.com> <20050505111324.GA17223@animx.eu.org> <58cb370e050505051360d0588c@mail.gmail.com> <1115304977.23360.83.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115304977.23360.83.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-05-05 at 13:13, Bartlomiej Zolnierkiewicz wrote:
> > Please be aware that new applications are expected to use
> > /sys/firmware/edd/default_* instead of legacy HDIO_GETGEO ioctl
> > and there is currently no way to set these sysfs entries (maybe it
> > would be worthwile to add such functionality?).
> 
> Please be aware that edd is platform specific, buggy and dependant on
> firmware features that many machines don't have. Don't use the EDD data
> its junk. Bartlomiej's advice isn't something I'd agree with on this
> point.

As stated in my last email, I am using EDD.  I only need the legacy heads
and sectors.  I can figure out the cylinders by that and the size of the
disk.

> The fundamental issue behind all this though and the problem with
> HDIO_GETGEO and friends is that geometry is basically a convenient
> fiction for legacy software that needs an answer and apps that interact
> with it.

Again, I am working with legacy stuff.  I'm trying to move away from 2.4 due
to the convienences of 2.6

> For PC type systems you actually want to go and look at the partition
> table itself and then follow that if one exists. If it doesn't exist
> then you are in firmware magic land and you need to look at the drive's
> current geometry reporting as well as the BIOS CMOS data, EDD on the
> boxes that have it, openprom etc and so forth. Or better yet look at
> parted and at least keep all the crap in one place.

I have some utils (mkdosfs comes to mind) that do not let the user specify
heads/sectors/cyls (it doesn't use cyl actually).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
