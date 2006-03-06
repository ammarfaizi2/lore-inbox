Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWCFXk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWCFXk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWCFXk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:40:59 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:42307 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932478AbWCFXk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:40:58 -0500
X-IronPort-AV: i="4.02,169,1139212800"; 
   d="scan'208"; a="412929648:sNHT33254660"
To: "David S. Miller" <davem@davemloft.net>
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <aday7zn432b.fsf@cisco.com>
	<20060306.143901.26500391.davem@davemloft.net>
	<adau0ab42ni.fsf@cisco.com>
	<20060306.145053.129802994.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 15:40:56 -0800
In-Reply-To: <20060306.145053.129802994.davem@davemloft.net> (David S. Miller's message of "Mon, 06 Mar 2006 14:50:53 -0800 (PST)")
Message-ID: <adapskz3zw7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 06 Mar 2006 23:40:57.0692 (UTC) FILETIME=[6AE4A1C0:01C64177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> I should look into getting some niagara machines to test
    Roland> with -- with PCIe slots they should actually be good for
    Roland> IB testing.

    David> You'll be cpu limited until we have Van Jacobson net
    David> channels.

For IPoIB maybe but not for native IB which offloads all transport to
the HCA... I'd be surprised if the bottleneck were anywhere other than
the bus, even on niagara.

    David> Also, since our existing Linux "generic" MSI code is so
    David> riddled with x86'isms (it was written by an Intel person,
    David> so this is just the status quo), it will be a while before
    David> MSI interrupts are supported on sparc64.

Yeah, I've always wanted to make the MSI stuff generic and handle the
embedded ppc chips that have MSI, but I've never had a good enough
reason to really work on it -- it's just been at the level of "that
would be fun."  Now that IBM cares I hope it will get done soon.

Anyway IB works fine with standard INTx interrupts -- MSI is just icing.

The Niagara boxes seem like a fun toy if I can get budget for it --
and 32 threads are probably good for flushing out SMP races.

 - R.
