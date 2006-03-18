Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWCRO4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWCRO4b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWCRO4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:56:31 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:28043 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S932225AbWCRO4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:56:30 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=gtMwPekuBx86Jad0GpgM4VrYhNPgP+e522Xq3hYUKfK29/of8ZMrvzUJr7fadxDYVGV8Fbq+klCB8XSbiWWH1d5/jWlROicdUpRonM8hQmD8mqSva7IbgSd70fwVehdk;
X-IronPort-AV: i="4.03,106,1141624800"; 
   d="scan'208"; a="61841199:sNHT30615612"
Date: Sat, 18 Mar 2006 08:56:22 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, matthew.e.tolentino@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-ID: <20060318145621.GA29862@humbolt.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <20060106172140.GB19605@lists.us.dell.com> <20060106223932.GB9230@lists.us.dell.com> <20060317155445.602f07b9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317155445.602f07b9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 03:54:45PM -0800, Andrew Morton wrote:
> It could be that Andi's changes break the ia64 dmi impementation - I don't
> know.  I guess it's OK if ia64 is not doing a scan "early".

It's not done "early", because at this point it's only needed for
drivers.  On i386 it's done "early" to catch some chipsets
(coincidentally, Dell).

> The above might not compile, but I'll make sure that it does so before
> releasing next -mm.
> 
> So.  Bottom line: please test the ia64 dmi patches in next -mm, send any
> needed fixups, thanks.


Built 2.6.16-rc6-mm2 on ia64 Itanium2 (Dell PowerEdge 7250, aka Intel
Tiger4).  Compiled clean, loaded clean, works as expected.  Thanks!

I haven't tried same on x86_64 yet, will get to that ASAP.

Thanks,
Matt
