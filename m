Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWGJVur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWGJVur (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWGJVur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:50:47 -0400
Received: from mga06.intel.com ([134.134.136.21]:61760 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964929AbWGJVuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:50:46 -0400
X-IronPort-AV: i="4.06,223,1149490800"; 
   d="scan'208"; a="63149186:sNHT1409937018"
Date: Mon, 10 Jul 2006 14:41:09 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: hawkes@sgi.com
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Paul Jackson <pj@sgi.com>, John Hawkes <jrhawkes@yahoo.com>
Subject: Re: [PATCH] build sched domains tracking cpusets
Message-ID: <20060710144109.A20509@unix-os.sc.intel.com>
References: <20060707193107.2870.60825.sendpatchset@tomahawk.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060707193107.2870.60825.sendpatchset@tomahawk.engr.sgi.com>; from hawkes@sgi.com on Fri, Jul 07, 2006 at 12:31:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 12:31:07PM -0700, hawkes@sgi.com wrote:
>From: "Nick Piggin" <nickpiggin@yahoo.com.au>
>>
>> Can you get away without using the bundle? Or does it make things easier?
>> You could add a new use_count to struct sched_domain if you'd like.... 
>> does it make the setup/teardown too difficult?
>
>The use_count is a ploy to reduce the demand for 
>SCHED_DOMAIN_CPUSET_MAX 
>slots.  I have been told that one popular job manager will create some 
>duplicate cpusets.
>
>The bundle is really there to simplify discovering the sched 
>group lists.

I think we can do away with the bundle. sd has a pointer to the sched_group
and the first cpu in sd->span can free the groups list allocation.

thanks,
suresh
