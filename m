Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTFIKHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTFIKHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:07:25 -0400
Received: from rth.ninka.net ([216.101.162.244]:5507 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261454AbTFIKHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:07:25 -0400
Subject: Re: [PATCH] [3/3] PCI segment support
From: "David S. Miller" <davem@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>
In-Reply-To: <20030609140749.A15138@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk>
	 <20030408203824.A27019@jurassic.park.msu.ru>
	 <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk>
	 <20030609140749.A15138@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055154054.9884.2.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jun 2003 03:20:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 03:07, Ivan Kokshaysky wrote:
> Looks good, but shouldn't we pass 'struct pci_bus *' instead
> of pci_dev to pci_domain_nr()?

I don't think it matters, but someone may find a useful
use of having the exact device available, who knows...

> Because another place where the domain number must be checked on is
> pci_bus_exists().

We could just pass the bus self device in this case.

-- 
David S. Miller <davem@redhat.com>
