Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317723AbSFLPXH>; Wed, 12 Jun 2002 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317724AbSFLPXG>; Wed, 12 Jun 2002 11:23:06 -0400
Received: from holomorphy.com ([66.224.33.161]:47520 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317723AbSFLPXG>;
	Wed, 12 Jun 2002 11:23:06 -0400
Date: Wed, 12 Jun 2002 08:22:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Robert Love <rml@tech9.net>,
        Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
Message-ID: <20020612152247.GH22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Robert Love <rml@tech9.net>,
	Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
	akpm@zip.com.au
In-Reply-To: <1023820116.22156.271.camel@sinai> <3215445436.1023869217@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 08:06:58AM -0700, Martin J. Bligh wrote:
> Indeed. And before that gets changed, it would be necessary
> to change the bootstrap procedure not to crash if you have
> more than NR_CPUS cpus (as Andrew reported it did), but instead 
> to just not configure them ... much less troublesome.
> M.

There are also fun deadlocks on i386 with "too many cpu's" as it
appears the kernel attempts to use logical APIC mode to get beyond
the eigth cpu and seems unaware that it can't IPI them that way unless
it's configured to always use the clustered hierarchical destination
format, though that's perhaps a little beyond just NR_CPUS. Perhaps
some kind of sanity checking is needed at the arch level for issues
like this as well, not just the absolute maximum number of cpu's?


Cheers,
Bill
