Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWCGALA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCGALA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCGAK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:10:59 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:43554 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1751283AbWCGAK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:10:58 -0500
X-IronPort-AV: i="4.02,169,1139212800"; 
   d="scan'208"; a="412938300:sNHT33019738"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for RDMA connection manager
X-Message-Flag: Warning: May contain useful information
References: <aday7zn432b.fsf@cisco.com>
	<20060306.143901.26500391.davem@davemloft.net>
	<adau0ab42ni.fsf@cisco.com>
	<20060306.145053.129802994.davem@davemloft.net>
	<adapskz3zw7.fsf@cisco.com>
	<1141689930.3814.69.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 16:10:56 -0800
In-Reply-To: <1141689930.3814.69.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Mon, 06 Mar 2006 16:05:30 -0800")
Message-ID: <adad5gz3yi7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Mar 2006 00:10:57.0973 (UTC) FILETIME=[9BF1B650:01C6417B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> Depends on the driver.  Ours needs the interrupt vector
    Bryan> rather than the number, which means we don't work without
    Bryan> CONFIG_PCI_MSI.  That is, unless there's some other way to
    Bryan> get the vector that I don't know about (entirely likely).

OK, fair enough.  But that's a quirk of the x86 architecture that
you're pretty tied to -- you don't actually need MSI, you just need
the interrupt numbering that is enabled on x86 with that config option.

Since Niagara boxes don't have HT anyway it's kind of a moot point.
Although I wonder what you would have to do to make your device work
with something like the MIPS SoCs that have HT...

 - R.
