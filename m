Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267894AbTAHW1D>; Wed, 8 Jan 2003 17:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTAHW1D>; Wed, 8 Jan 2003 17:27:03 -0500
Received: from palrel13.hp.com ([156.153.255.238]:5814 "HELO palrel13.hp.com")
	by vger.kernel.org with SMTP id <S267894AbTAHW1C>;
	Wed, 8 Jan 2003 17:27:02 -0500
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] PCI: allow alternative methods for probing the BARs 
In-Reply-To: Message from Ivan Kokshaysky <ink@jurassic.park.msu.ru> 
   of "Wed, 08 Jan 2003 17:47:11 +0300." <20030108174711.A15896@jurassic.park.msu.ru> 
References: <Pine.LNX.4.44.0301052009050.3087-100000@home.transmeta.com> <1041848998.666.4.camel@zion.wanadoo.fr> <20030106194513.GC26790@cup.hp.com> <20030107200537.B559@localhost.park.msu.ru> <20030107201700.GB32722@cup.hp.com>  <20030108174711.A15896@jurassic.park.msu.ru> 
Date: Wed, 08 Jan 2003 14:34:13 -0800
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <20030108223414.3D97212C2F@debian.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Tue, Jan 07, 2003 at 12:17:00PM -0800, Grant Grundler wrote:
> > BTW, please don't equate PCI controller instance number with PCI Domain.
> 
> I agree, it's quite confusing. However, I don't think that the PCI spec
> defines "PCI controller" or "PCI domain" terms, it's pretty much
> implementation specific.

Oh. The definition I was using is based on which PCI devices can do
peer-to-peer transactions. ie a "PCI Domain" is defined by the
PCI MMIO address space routing.

> Assuming that each PCI controller can handle up to 256 bridged buses,
> the unique PCI controller index and PCI bus number is all that userspace
> needs to know in order to properly identify devices in the system.

yes - that makes sense for configuration space accesses.
I can see why you'd call this a "PCI Domain" as well.

The platforms I was commenting on can only generate config cycles below
a PCI "Host Bus Adapter" (aka controller).

thanks,
grant
