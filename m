Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbTFIJyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 05:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbTFIJyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 05:54:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:24585 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262166AbTFIJyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 05:54:45 -0400
Date: Mon, 9 Jun 2003 14:07:49 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609140749.A15138@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Sun, Jun 08, 2003 at 05:43:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 05:43:51PM +0100, Matthew Wilcox wrote:
>  - Use pci_domain_nr() macro to determine which domain a bus or device
>    is in.
>  - Default implementation for architectures which don't support PCI
>    domains.
>  - Implementation for ia64.

Looks good, but shouldn't we pass 'struct pci_bus *' instead
of pci_dev to pci_domain_nr()?
Because another place where the domain number must be checked on is
pci_bus_exists().

Ivan.
