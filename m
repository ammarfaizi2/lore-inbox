Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVADAUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVADAUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVADAUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:20:11 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24968 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262010AbVADASE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:18:04 -0500
Date: Tue, 4 Jan 2005 01:14:54 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [ide] clean up error path in do_ide_setup_pci_device()
Message-ID: <20050104001454.GA7655@electric-eye.fr.zoreil.com>
References: <200412310343.iBV3hqvd015595@hera.kernel.org> <1104773262.13302.3.camel@localhost.localdomain> <58cb370e050103142269e1f67f@mail.gmail.com> <1104788671.13302.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104788671.13302.63.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> :
[...]
> One example where the weird design makes it obvious is the CS5520. Here
> the 5520 bridge has the IDE in one BAR and all sorts of other logic
> (including the xBUS virtual ISA environment) in the same PCI function.
> On that chip a pci_disable_device on the IDE pci_dev turns off mundane
> things like the timer chips keyboard and mouse 8).

/me looks at the comments in drivers/ide/pci/cs5520.c

Is it worth the pain to remember if ide_setup_pci_device() did enable a
specific bar or not in order to balance it more accurately ?

--
Ueimor
