Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135897AbREIXoZ>; Wed, 9 May 2001 19:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135895AbREIXoG>; Wed, 9 May 2001 19:44:06 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:17412 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S135883AbREIXns>; Wed, 9 May 2001 19:43:48 -0400
Date: Wed, 9 May 2001 19:43:48 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch to make ymfpci legacy address 16 bits
In-Reply-To: <3AF9B1BF.A6BCCCE2@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0105091915010.17812-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff!

> Basically the PCI core should implement what PM is necessary, because
> eventually struct pci_driver will become a more generic struct driver.

I just wanted to make sure that you don't expect any problems if we go
this way.

> Why does maestro.c not use my suggestion?  Because it doesn't use struct
> pci_driver.

I see. It's not a pure PCI driver. I wonder what happens if some other
driver becomes "impure" e.g. by adding PCMCIA support.

> Why does trident.c not use my suggestion?  Only because noone has
> written and tested the patch for it yet :)  It uses struct pci_driver
> and should be updated to use ::suspend/resume.

First part (writing the patch) is done:

http://www.red-bean.com/~proski/linux/trident_pm.diff

I only know that it compiles. I have no hardware I can test it on. Please
don't apply until tested!

-- 
Regards,
Pavel Roskin

