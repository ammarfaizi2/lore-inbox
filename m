Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTAQXFb>; Fri, 17 Jan 2003 18:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTAQXFb>; Fri, 17 Jan 2003 18:05:31 -0500
Received: from holomorphy.com ([66.224.33.161]:28568 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261732AbTAQXFa>;
	Fri, 17 Jan 2003 18:05:30 -0500
Date: Fri, 17 Jan 2003 15:14:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: MAX_IO_APICS #ifdef'd wrongly
Message-ID: <20030117231417.GT919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, akpm@zip.com.au,
	linux-kernel@vger.kernel.org
References: <20030117090031.GD940@holomorphy.com> <224570000.1042818820@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224570000.1042818820@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 07:53:41AM -0800, Martin J. Bligh wrote:
> Summit needs this too, so it should really be CONFIG_NUMA at least.
> Ideally this would go into subarch if we can move it cleanly (hint, hint ;-))
> But other than that, yes ... I'll merge it.
> Thanks,

I shot for the one liner that fixed the case I could test. Shoving it
into subarch is cleaner, but needs more code movement and changes the
prior semantics. The prior semantics were broken for larger Summit
configurations, hmm. Maybe _all_ the array sizes should go into some
kind of subarch analogue of param.h, e.g. mach_param.h

The only one I can think of that doesn't fly is NR_IRQS; once there
are more interrupt sources than FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR
the whole of arch/i386/ appears to explode.

Someone somewhere should probably take notice of that.


Bill
