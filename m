Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbVIHGLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbVIHGLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 02:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbVIHGLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 02:11:24 -0400
Received: from dvhart.com ([64.146.134.43]:25226 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932645AbVIHGLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 02:11:23 -0400
Date: Wed, 07 Sep 2005 23:11:29 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, magnus@valinux.co.jp, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, andyw@uk.ibm.com
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
Message-ID: <40650000.1126159888@[10.10.2.4]>
In-Reply-To: <20050907164945.14aba736.akpm@osdl.org>
References: <20050906035531.31603.46449.sendpatchset@cherry.local><1126114116.7329.16.camel@localhost><512850000.1126117362@flay><1126117674.7329.27.camel@localhost><521510000.1126118091@flay> <20050907164945.14aba736.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
>> >> machines. This is essential in order for the distros to support it - same
>> >> will go for sparsemem.
>> > 
>> > That's a different issue.  The current code works if you boot a NUMA=y
>> > SPARSEMEM=y machine with a single node.  The current Kconfig options
>> > also enforce that SPARSEMEM depends on NUMA on i386.
>> > 
>> > Magnus would like to enable SPARSEMEM=y while CONFIG_NUMA=n.  That
>> > requires some Kconfig changes, as well as an extra memory present call.
>> > I'm questioning why we need to do that when we could never do
>> > DISCONTIG=y while NUMA=n on i386.
>> 
>> Ah, OK - makes more sense. However, some machines do have large holes
>> in e820 map setups - is not really critical, more of an efficiency
>> thing.
> 
> Confused.   Does all this mean that we want the patch, or not?

>From that POV, nothing urgent, and would require more work to make use
of it anyway. Not sure if Magnus had another more immediate use for it?

M.
