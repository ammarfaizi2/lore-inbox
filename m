Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757478AbWKWVhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478AbWKWVhS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 16:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757480AbWKWVhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 16:37:18 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8157 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757478AbWKWVhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 16:37:16 -0500
Date: Thu, 23 Nov 2006 21:42:48 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 3/5] PCI : Add selected_regions funcs
Message-ID: <20061123214248.6251a4c0@localhost.localdomain>
In-Reply-To: <200611232033.35280.ioe-lkml@rameria.de>
References: <456404FE.1040708@jp.fujitsu.com>
	<200611232033.35280.ioe-lkml@rameria.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006 20:33:32 +0100
Ingo Oeser <ioe-lkml@rameria.de> wrote:

> Hi Hidetoshi Seto,
> 
> bitfields (and bitmask) should be unsigned and use machine word size,
> which is usually "long". So please pass them in "unsigned long" instead of "int".

There are a fixed number of BARs , besides which the interface already
uses int for the mask in pci_enable_device_bars() so the use of int is
fine and continues the existing API.

