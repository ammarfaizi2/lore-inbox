Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267816AbTAHOlw>; Wed, 8 Jan 2003 09:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267817AbTAHOlw>; Wed, 8 Jan 2003 09:41:52 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:6665 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267816AbTAHOlu>; Wed, 8 Jan 2003 09:41:50 -0500
Date: Wed, 8 Jan 2003 17:47:11 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs
Message-ID: <20030108174711.A15896@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr> <20030106194513.GC26790@cup.hp.com> <20030107200537.B559@localhost.park.msu.ru> <20030107201700.GB32722@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030107201700.GB32722@cup.hp.com>; from grundler@cup.hp.com on Tue, Jan 07, 2003 at 12:17:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 12:17:00PM -0800, Grant Grundler wrote:
> BTW, please don't equate PCI controller instance number with PCI Domain.

I agree, it's quite confusing. However, I don't think that the PCI spec
defines "PCI controller" or "PCI domain" terms, it's pretty much
implementation specific.
Assuming that each PCI controller can handle up to 256 bridged buses,
the unique PCI controller index and PCI bus number is all that userspace
needs to know in order to properly identify devices in the system.

> Current parisc platforms implement one PCI address space for each SBA
> (System Bus Adapter). HP ZX1 (IA64) platforms are based on parisc designs.
> Each SBA can have something like 8 or 16 PCI controllers below it.

It's somewhat similar to new alpha-ev7 systems: it can have 1 I/O
controller per CPU where each I/O controller has a 4x AGP bus and 3
PCI/PCI-X buses. However, each of these buses has its own address
space and IOMMU.

Ivan.
