Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315442AbSFEOUz>; Wed, 5 Jun 2002 10:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315446AbSFEOUy>; Wed, 5 Jun 2002 10:20:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:10502 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315442AbSFEOUx>; Wed, 5 Jun 2002 10:20:53 -0400
Date: Wed, 5 Jun 2002 18:20:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Patrick Mochel <mochel@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020605182016.A3437@jurassic.park.msu.ru>
In-Reply-To: <20020604210745.A849@jurassic.park.msu.ru> <Pine.LNX.4.33.0206041128020.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 11:58:39AM -0700, Patrick Mochel wrote:
> My point is that the only thing pcibios_init() appears to be doing on 
> alpha is probing the bus.

No. Look at pci_assign_unassigned_resources() in drivers/pci/setup-bus.c.
Setting the BARs, initializing bridges etc. That's that i386 expects
to be done in BIOS.

Ivan.
