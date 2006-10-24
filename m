Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422674AbWJXVve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbWJXVve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWJXVvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:51:33 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:29056 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1161226AbWJXVvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:51:32 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jeff@garzik.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org, John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org>
	<20061024214724.GS25210@parisc-linux.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 24 Oct 2006 14:51:30 -0700
In-Reply-To: <20061024214724.GS25210@parisc-linux.org> (Matthew Wilcox's message of "Tue, 24 Oct 2006 15:47:24 -0600")
Message-ID: <adar6wxbcwt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Oct 2006 21:51:31.0168 (UTC) FILETIME=[90C69600:01C6F7B6]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I think the right way to fix this is to ensure mmio write ordering in
 > the pci_write_config_*() implementations.  Like this.

I'm happy to fix this in the PCI core and not force drivers to worry
about this.

John, can you confirm that this patch fixes the issue for you?

Thanks,
  Roland
