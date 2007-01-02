Return-Path: <linux-kernel-owner+w=401wt.eu-S965013AbXABWiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbXABWiN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbXABWiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:38:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51660 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965013AbXABWiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:38:11 -0500
Date: Tue, 2 Jan 2007 22:48:19 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
Message-ID: <20070102224819.4e3555fa@localhost.localdomain>
In-Reply-To: <459ACF51.1010501@garzik.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
	<459973F6.2090201@pobox.com>
	<20070102115834.1e7644b2@localhost.localdomain>
	<459AC808.1030807@pobox.com>
	<20070102212701.4b4535cf@localhost.localdomain>
	<459ACE9C.7020107@pobox.com>
	<459ACF51.1010501@garzik.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jan 2007 16:32:01 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Jeff Garzik wrote:
> > * After your patch, the code explicitly calls pci_request_region() for 
> > BARs 0-4, but never for BAR5.
> 
> Without checking for failures, I might add.

The old code didn't reserve 1 or 3 at all let alone check them!

> I agree this is one way to avoid conflicts!  ;-)

I did actually go through and verify that there are no drivers where this
would cause a problem including reading some of the painful crap in
drivers/ide to double check.

Is it perfection - no, does it fix 2.6.20 - yes, is it causing any
problems for a 2.6.21 roadmap - no.

Alan
