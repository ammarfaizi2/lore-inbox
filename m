Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbTGHT5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267572AbTGHT4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:56:43 -0400
Received: from ns.suse.de ([213.95.15.193]:34579 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265297AbTGHT4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:56:07 -0400
Date: Tue, 8 Jul 2003 22:10:41 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davem@redhat.com, alan@lxorguk.ukuu.org.uk, grundler@parisc-linux.org,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-Id: <20030708221041.740d4ca3.ak@suse.de>
In-Reply-To: <20030708194744.GD17115@gtf.org>
References: <20030702235619.GA21567@wotan.suse.de>
	<1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk>
	<20030703212415.GA30277@wotan.suse.de>
	<20030707.191438.71104854.davem@redhat.com>
	<20030708213427.39de0195.ak@suse.de>
	<20030708194744.GD17115@gtf.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 15:47:44 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> Personally, I've always thought we were kidding ourselves by not doing
> the error checking you describe.  From my somewhat-narrow perspective of
> network drivers and the libata storage driver, you have to deal with
> atomic allocations _anyway_ ...  so why not make sure IOMMU overflow
> properly fails at the pci_map_foo level?

pci_map_single currently has no defined error return, but if you could 
persuade all your drivers colleagues to fix their drivers to check
this I'm sure things would be better.

(on AMD64 the check could be trivially implemented as a macro because errors
always return a well defined address)

-Andi
