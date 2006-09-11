Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWIKMpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWIKMpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 08:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWIKMpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 08:45:18 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:32959 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964790AbWIKMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 08:45:16 -0400
Date: Mon, 11 Sep 2006 08:41:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Cache line size
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       John Richard Moser <nigelenki@comcast.net>
Message-ID: <200609110842_MC3-1-CAD5-5E83@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060911053144.GB18727@redhat.com>

On Mon, 11 Sep 2006 01:31:44 -0400, Dave Jones wrote:

> > > Is there a way for the Linux Kernel to know the cache line size of the
> > > CPU it's on, besides #define X86_CACHE_LINE_SZ 32 or whatnot?
> > 
> > /sys/devices/system/cpu/cpu<N>/cache
>
> Hmm..
>
> $ find /sys/ -name cache
> $
>
> That's on 2.6.18rc6.  Is this some -mm only feature?

Looks like it's only there on Intel CPUs with CPUID level >= 0x00000004
and AMD CPUs with extended CPUID level >= 0x80000006, like this one:

vendor_id       : AuthenticAMD
cpu family      : 15
model           : 72

It's not there on:

vendor_id       : GenuineIntel
cpu family      : 6
model           : 6

Oh well...  

-- 
Chuck

