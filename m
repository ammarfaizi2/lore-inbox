Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262621AbVGHGOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVGHGOa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVGHGOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 02:14:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33974 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262621AbVGHGO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 02:14:29 -0400
Date: Thu, 7 Jul 2005 23:14:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       tpmdd-devel@lists.sourceforge.net,
       Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: 2.6.12 breaks 8139cp [PATCH 1 of 2]
Message-ID: <20050708061410.GU9046@shell0.pdx.osdl.net>
References: <42C16162.2070208@drzeus.cx> <1119971339.6382.18.camel@localhost.localdomain> <20050628172300.GE9153@shell0.pdx.osdl.net> <1119990572.6403.8.camel@localhost.localdomain> <20050628203408.GA9046@shell0.pdx.osdl.net> <1119996659.6403.14.camel@localhost.localdomain> <42C25A3A.1070206@drzeus.cx> <1120055548.7079.1.camel@localhost.localdomain> <20050705153512.GJ9046@shell0.pdx.osdl.net> <1120766495.5474.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120766495.5474.21.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> A problem was reported that the tpm driver was interfereing with
> networking on the 8139 chipset.  The tpm driver was using a hard coded
> the memory address instead of the value the BIOS was putting the chip
> at.  This was in the tpm_lpc_bus_init function.  That function can be
> replaced with querying the value at Vendor specific locations.  This
> patch replaces all calls to tpm_lpc_bus_init and the hardcoding of the
> base address with a lookup of the address at the correct vendor
> location.

Thanks Kylene.  Looks like it's just no longer deleting tpm_lpc_bus_init.
So with that nice changelog, I think we'll just go with the full version.
Sorry for the extra work, I thought there might be a simple method by
passing lo/hi and doing tpm_read_index in tpm_lpc_bus_init to set base.

thanks,
-chris
