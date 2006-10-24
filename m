Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWJXVYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWJXVYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWJXVYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:24:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57528 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965205AbWJXVYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:24:51 -0400
Subject: Re: Ordering between PCI config space writes and MMIO reads?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
In-Reply-To: <adafyddcysw.fsf@cisco.com>
References: <adafyddcysw.fsf@cisco.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Oct 2006 22:24:23 +0100
Message-Id: <1161725063.22348.39.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-24 am 12:13 -0700, ysgrifennodd Roland Dreier:
>  1) Is this something that should be fixed in the driver?  The PCI
>     spec allows MMIO cycles to start before an earlier config cycle
>     completed, but do we want to expose this fact to drivers?  Would
>     it be better for ia64 to use some sort of barrier to make sure
>     pci_write_config_xxx() is strongly ordered with MMIO?

It is good to be conservative in this area. Some AMD chipsets at least
had ordering problems with some configurations in the K7 era.


