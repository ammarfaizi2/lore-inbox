Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWCFWuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWCFWuu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbWCFWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:50:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6021
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751675AbWCFWus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:50:48 -0500
Date: Mon, 06 Mar 2006 14:50:53 -0800 (PST)
Message-Id: <20060306.145053.129802994.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for
 RDMA connection manager
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adau0ab42ni.fsf@cisco.com>
References: <aday7zn432b.fsf@cisco.com>
	<20060306.143901.26500391.davem@davemloft.net>
	<adau0ab42ni.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 14:41:21 -0800

> I should look into getting some niagara machines to test with -- with
> PCIe slots they should actually be good for IB testing.

You'll be cpu limited until we have Van Jacobson net channels.

Also, since our existing Linux "generic" MSI code is so riddled with
x86'isms (it was written by an Intel person, so this is just the
status quo), it will be a while before MSI interrupts are supported on
sparc64.

I haven't gotten around to working on that problem yet, and PPC needs
this work too as they now have MSI capable PCI controllers.
