Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136576AbREIQHL>; Wed, 9 May 2001 12:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136578AbREIQHA>; Wed, 9 May 2001 12:07:00 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61706 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136576AbREIQGr>; Wed, 9 May 2001 12:06:47 -0400
Subject: Re: 2.4.4-ac5 aic7xxx causes hang on my machine
To: dledford@redhat.com (Doug Ledford)
Date: Wed, 9 May 2001 17:10:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        bennyb@ntplx.net (Benedict Bridgwater),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3AF967B5.E9FD1223@redhat.com> from "Doug Ledford" at May 09, 2001 11:52:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xWXu-0002fq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > IRQ11 appearing on IRQ10 sounds exactly like the INTA-D line setting for IRQ
> > 11 is wrong and we connected it to IRQ 10
> 
> Which brings me back to my question in my previous email.  Why are we
> remapping working configs again?  I'm at a loss here.  This isn't a hot plug
> capably motherboard, we don't have to worry about new PCI cards getting thrown
> in, and yet we are remapping the IRQs.  Why?

Ok and how do you propose to implement

	int gee_whiz_this_configuration_works(void)

Remembering that there are several devices/setups that _only_ work in 2.4 
because we set things up ourselves. Stuff that isnt hot plug. Little things
like the sound on the vaio. In fact if the BIOS is in PnP OS mode (which on
some newer bioses is the only option) we _have_ to set stuff up.

Now how about checking the BIOS tables and seeing if they are wrong. If so then
someone can do something about it. Right now this is speculation and needs
verifying.

Alan

