Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276124AbRI1PYl>; Fri, 28 Sep 2001 11:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276122AbRI1PXw>; Fri, 28 Sep 2001 11:23:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15367 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276123AbRI1PX3>; Fri, 28 Sep 2001 11:23:29 -0400
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
To: jdthood@mail.com (Thomas Hood)
Date: Fri, 28 Sep 2001 16:28:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BB49543.6A915332@mail.com> from "Thomas Hood" at Sep 28, 2001 11:20:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mzZF-0007NO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The only remaining problem is that the DMI scan routines are
> > called _after_ the PnP BIOS scan, so the is_sony_vaio_laptop
> > variable will be always evaluated to 0 in your patch (causing
> > the same hang again).
> 
> This is unfortunate.  :(

We need to move the DMI scan earlier anyway to handle 440GX boards
