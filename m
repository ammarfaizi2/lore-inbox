Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTAIRuC>; Thu, 9 Jan 2003 12:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTAIRuC>; Thu, 9 Jan 2003 12:50:02 -0500
Received: from [217.167.51.129] ([217.167.51.129]:28631 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266936AbTAIRuA>;
	Thu, 9 Jan 2003 12:50:00 -0500
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <20030109204626.A2007@jurassic.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk>
	 <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com>
	 <20030109204626.A2007@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042134735.522.19.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Jan 2003 18:52:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 18:46, Ivan Kokshaysky wrote:

> There is no need for changes to arch-specific code, as everything
> is hidden in pci_scan_bus(). However, it's possible to use
> pci_scan_bus_parented() and pci_probe_resources() directly,
> because some arch-specific fixups between these two might
> be useful.
> 
> Note: on powermacs, if the I/O ASIC is behind PCI-PCI bridge, the
> bridge device probably should be marked as "skip_probe" as well.

Good.

Yes, On these, I'll skip the pci<->pci bridge in cases there is one on
the path too, this will add some nasty logic to the pmac pci code, but
that's ok as long as that crap doesn't leak out of
arch/ppc/platforms/pmac_*

Ben.

