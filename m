Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWDNUxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWDNUxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 16:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWDNUxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 16:53:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:53063 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S965147AbWDNUxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 16:53:49 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23382911:sNHT16223011"
Date: Fri, 14 Apr 2006 13:53:45 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davej@codemonkey.org.uk, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, ak@suse.de,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/7] [RFC] Sizing zones and holes in an architecture independent manner V2
Message-ID: <20060414205345.GA1258@agluck-lia64.sc.intel.com>
References: <20060412232036.18862.84118.sendpatchset@skynet> <20060413095207.GA4047@skynet.ie> <20060413171942.GA15047@agluck-lia64.sc.intel.com> <20060413173008.GA19402@skynet.ie> <20060413174720.GA15183@agluck-lia64.sc.intel.com> <20060413191402.GA20606@skynet.ie> <20060413215358.GA15957@agluck-lia64.sc.intel.com> <20060414131235.GA19064@skynet.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060414131235.GA19064@skynet.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 02:12:35PM +0100, Mel Gorman wrote:
> That appears fine, but I call add_active_range() after a GRANULEROUNDUP and
> GRANULEROUNDDOWN has taken place so that might be the problem, especially as
> all those ranges are aligned on a 16MiB boundary. The following patch calls
> add_active_range() before the rounding takes place. Can you try it out please?

That's good.  Now I see identical output before/after your patch for
the generic (DISCONTIG=y) kernel:

On node 0 totalpages: 259873
  DMA zone: 128931 pages, LIFO batch:7
  Normal zone: 130942 pages, LIFO batch:7

-Tony
