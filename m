Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315446AbSFEOXu>; Wed, 5 Jun 2002 10:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315447AbSFEOXt>; Wed, 5 Jun 2002 10:23:49 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:11782 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315446AbSFEOXs>; Wed, 5 Jun 2002 10:23:48 -0400
Date: Wed, 5 Jun 2002 18:23:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Patrick Mochel <mochel@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020605182316.B3437@jurassic.park.msu.ru>
In-Reply-To: <20020604.143453.35012407.davem@redhat.com> <Pine.LNX.4.33.0206041502200.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 03:03:33PM -0700, Patrick Mochel wrote:
> -subsys_initcall(pci_driver_init);
> +postcore_initcall(pci_driver_init);

Fine, but my main objection was to pci_driver_init being an initcall
in general, no matter in what level. With current code we may have
pci_bus_type registered on a machine without PCI bus.
Real life example: jensen running generic alpha kernel.

Ivan.
