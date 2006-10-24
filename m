Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbWJXVaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbWJXVaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbWJXVaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:30:08 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:8967 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S965206AbWJXVaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:30:02 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <adafyddcysw.fsf@cisco.com>
	<1161725063.22348.39.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 24 Oct 2006 14:29:47 -0700
In-Reply-To: <1161725063.22348.39.camel@localhost.localdomain> (Alan Cox's message of "Tue, 24 Oct 2006 22:24:23 +0100")
Message-ID: <aday7r5bdx0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Oct 2006 21:29:47.0600 (UTC) FILETIME=[87C9E500:01C6F7B3]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It is good to be conservative in this area. Some AMD chipsets at least
 > had ordering problems with some configurations in the K7 era.

Could you expand a little?  Do you mean that the arch implementation
of pci_write_config_xxx() should have extra barriers, or that drivers
should do belt-and-suspenders flushes to make sure config writes are
really done properly?

 - R.
