Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315577AbSEQKso>; Fri, 17 May 2002 06:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315580AbSEQKsn>; Fri, 17 May 2002 06:48:43 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:64265 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315577AbSEQKsl>; Fri, 17 May 2002 06:48:41 -0400
Date: Fri, 17 May 2002 14:47:55 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        "Patrick Mochel (mochel@osdl.org)" <mochel@osdl.org>,
        "'davem@redhat.com'" <davem@redhat.com>,
        "'Greg@kroah.com'" <Greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: pci segments/domains
Message-ID: <20020517144755.A16767@jurassic.park.msu.ru>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7E45@orsmsx111.jf.intel.com> <3CE4098E.2070808@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 03:33:34PM -0400, Jeff Garzik wrote:
> I wouldn't mind making the PCI domain support a bit more explicit, 
> though.  I think it's fair to be able to obtain a pointer to "struct 
> pci_domain", which would most likely be defined in asm/pci.h for each arch.

We already have it - void *sysdata. Host-to-PCI (domain) controllers might
be totally different even inside any given architecture, so trying to
make this more generic would be pointless - you will end up with a pointer
to arch/device specific data anyway.
I can think of the only case where domain info might be interesting - if
some device wants to know whether it can talk to another device directly.
We have pci_controller_num(pdev) for this.

Ivan.
