Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbRF2FWe>; Fri, 29 Jun 2001 01:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265545AbRF2FWY>; Fri, 29 Jun 2001 01:22:24 -0400
Received: from are.twiddle.net ([64.81.246.98]:43423 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265542AbRF2FWN>;
	Fri, 29 Jun 2001 01:22:13 -0400
Date: Thu, 28 Jun 2001 22:22:01 -0700
From: Richard Henderson <rth@twiddle.net>
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Changes for PCI
Message-ID: <20010628222201.A2521@twiddle.net>
Mail-Followup-To: Tom Gall <tom_gall@vnet.ibm.com>,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B3A58FC.2728DAFF@vnet.ibm.com> <3B3A5B00.9FF387C9@mandrakesoft.com> <3B3A64CD.28B72A2A@vnet.ibm.com> <15162.33332.781686.45753@pizda.ninka.net> <3B3A2EF9.4A44264F@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B3A2EF9.4A44264F@vnet.ibm.com>; from tom_gall@vnet.ibm.com on Wed, Jun 27, 2001 at 02:07:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 02:07:37PM -0500, Tom Gall wrote:
> Consider also in drivers/pci/pci.c:
> 
> The function pci_bus_exists checks based on bus numbers. This function is
> of course used by pci_alloc_primary_bus, which is in turn used by
> pci_scan_bus. As is today, this code can break me the second I'm
> onto my second PCI system domain.

You'll find that the existing ports that support multiple pci
domains do not number the busses on the secondary domains from
zero.  If domain 0 has 3 busses, then domain 1's root bus will
be bus number 3, and so on.

This approach works quite well in practice, even on machines
with large numbers of pci domains, since there tends to be no
pci-pci busses on domains other than the one containing legacy
i/o widgetry.


r~
