Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWBRRB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWBRRB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBRRB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:01:26 -0500
Received: from krusty.pcisys.net ([216.229.32.178]:27553 "EHLO
	krusty.pcisys.net") by vger.kernel.org with ESMTP id S932080AbWBRRBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:01:25 -0500
Date: Sat, 18 Feb 2006 10:01:26 -0700
From: Brian Hall <brihall@pcisys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: Help: DGE-560T not recognized by Linux
Message-Id: <20060218100126.198d86c3.brihall@pcisys.net>
In-Reply-To: <20060217234841.5f2030ec.akpm@osdl.org>
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	<20060217222428.3cf33f25.akpm@osdl.org>
	<20060218003622.30a2b501.brihall@pcisys.net>
	<20060217234841.5f2030ec.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006 23:48:41 -0800
Andrew Morton <akpm@osdl.org> wrote:
> Brian Hall <brihall@pcisys.net> wrote:
> >  I see that the sky2 driver in 2.6.16rc4 lists my card, but for some
> >  reason it fails to access the card, maybe because I have an ULi
> > chipset?
> > 
> >  Feb 17 23:18:46 syrinx sky2 0000:02:00.0: can't access PCI config
> > space
> 
> Looks like something died way down in the PCI bus config space
> read/write operations.  I don't know what would cause that.  You
> could perhaps play with `pci=conf1', `pci=conf2', etc as per
> Documentation/kernel-parameters.txt.

OK, I tried all these pci= options, plus acpi=off, to no effect:
conf1, conf2, nommconf, biosirq, noacpi, routeirq, nosort, rom,
lastbus=2, assign-busses, usepirqmask acpi=off

Also tried adjusting PCIe-related stuff in the BIOS (underclocking PCIe
from 100 to 70 and adjusting Northbridge options). No change.

Unfortunately this is the only PCIe card I have (my video is a AGP
Radeon 9200). Do I need to force this card to be enabled somehow with a
setpci command?

--
Brian Hall
Linux Consultant
http://pcisys.net/~brihall
