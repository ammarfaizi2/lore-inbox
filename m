Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945943AbWJaT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945943AbWJaT6O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWJaT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:58:13 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:34216 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1945941AbWJaT6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:58:12 -0500
Date: Tue, 31 Oct 2006 12:58:11 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeff@garzik.org, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
Message-ID: <20061031195811.GF26964@parisc-linux.org>
References: <20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org> <20061024.154347.77057163.davem@davemloft.net> <aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com> <20061031195312.GD5950@mellanox.co.il> <ada8xiwtg81.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada8xiwtg81.fsf@cisco.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 11:53:02AM -0800, Roland Dreier wrote:
>  > Here's what I don't understand: according to PCI rules, pci config read
>  > can bypass pci config write (both are non-posted).
>  > So why does doing it help flush the writes as the comment claims?
> 
> No, I don't believe a read of a config register can pass a write of
> the same register.  (Someone correct me if I'm wrong)

I don't see anything in the PCI spec which forbids it, but I would
expect that hardware designers don't actually do that in practice.
