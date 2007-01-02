Return-Path: <linux-kernel-owner+w=401wt.eu-S965003AbXABWgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbXABWgA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbXABWgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:36:00 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39859 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965003AbXABWf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:35:59 -0500
Date: Tue, 2 Jan 2007 22:45:59 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070102224559.2089d28d@localhost.localdomain>
In-Reply-To: <459ACE9C.7020107@pobox.com>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
	<20070102115834.1e7644b2@localhost.localdomain>
	<459AC808.1030807@pobox.com>
	<20070102212701.4b4535cf@localhost.localdomain>
	<459ACE9C.7020107@pobox.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We use BAR5 on two devices in legacy mode. Both of those reserve all the
> > other resources.
> 
> Translation:  You want to hand-wave away an obvious regression that YOU 
> have created with your fix-to-a-fix.

It's not regressing anything.

> Why INTRODUCE these 2.6.20 Alan-isms, if they are going away in 2.6.21?

To fix the problem I introduced ? and because that patch to do so is
trivial and easy to test and verify. 

> * Prior to your patch, ata_piix in legacy mode calls 
> pci_request_regions() to intentionally reserve ALL regions on the PCI 
> device.

Actually it didn't reserve BAR1 and BAR3 in legacy mode precisely because
of the PCI resource mismanagement in the old tree. So you take your pick.
BAR1 and BAR3 were used on all devices and not reserved, BAR5 is used on
two. Neither case is actually a problem in the current tree and driver
set. Both will be fixed when the combined mode junk gets fired into
hyperspace.

Alan
