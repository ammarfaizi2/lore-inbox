Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVADXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVADXPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVADXPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:15:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18102 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262120AbVADXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:07:13 -0500
Subject: Re: [ide] clean up error path in do_ide_setup_pci_device()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20050104001454.GA7655@electric-eye.fr.zoreil.com>
References: <200412310343.iBV3hqvd015595@hera.kernel.org>
	 <1104773262.13302.3.camel@localhost.localdomain>
	 <58cb370e050103142269e1f67f@mail.gmail.com>
	 <1104788671.13302.63.camel@localhost.localdomain>
	 <20050104001454.GA7655@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104854560.17176.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 22:02:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-04 at 00:14, Francois Romieu wrote:
> /me looks at the comments in drivers/ide/pci/cs5520.c
> 
> Is it worth the pain to remember if ide_setup_pci_device() did enable a
> specific bar or not in order to balance it more accurately ?

I'm not sure that tells you enough about the device to know how to
disable it or if it is safe to disable. It might be better to just check
if the device is currently enabled, if the enable bits were off then you
know you can disable it again.

