Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945917AbWJaTxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945917AbWJaTxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945915AbWJaTxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:53:10 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:8495 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1945913AbWJaTxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:53:09 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, jeff@garzik.org,
       matthew@wil.cx, openib-general@openib.org,
       linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <20061024214724.GS25210@parisc-linux.org>
	<adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org>
	<20061024.154347.77057163.davem@davemloft.net>
	<aday7r4a3d7.fsf@cisco.com> <adad588tijq.fsf@cisco.com>
	<20061031195312.GD5950@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 31 Oct 2006 11:53:02 -0800
In-Reply-To: <20061031195312.GD5950@mellanox.co.il> (Michael S. Tsirkin's message of "Tue, 31 Oct 2006 21:53:12 +0200")
Message-ID: <ada8xiwtg81.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Oct 2006 19:53:03.0890 (UTC) FILETIME=[2D664720:01C6FD26]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Here's what I don't understand: according to PCI rules, pci config read
 > can bypass pci config write (both are non-posted).
 > So why does doing it help flush the writes as the comment claims?

No, I don't believe a read of a config register can pass a write of
the same register.  (Someone correct me if I'm wrong)

 - R.
