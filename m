Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274926AbSITEKH>; Fri, 20 Sep 2002 00:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274927AbSITEKH>; Fri, 20 Sep 2002 00:10:07 -0400
Received: from holomorphy.com ([66.224.33.161]:56709 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S274926AbSITEKG>;
	Fri, 20 Sep 2002 00:10:06 -0400
Date: Thu, 19 Sep 2002 21:09:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [BUG] x86_udelay_tsc not honoring notsc
Message-ID: <20020920040905.GG3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu
References: <20020920035258.GR28202@holomorphy.com> <466275568.1032469207@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <466275568.1032469207@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> If so, it's probably not worth mucking around with the bootstrap
>> sequence to deal with something this minor. It's not like it can
>> be mistaken for having hung, as console output is very consistent.
>> Maybe we should give NUMA-Q a couple of minutes instead of 5s?

On Thu, Sep 19, 2002 at 09:00:09PM -0700, Martin J. Bligh wrote:
> Nah, just recode the boot sequence to make them all boot in 
> parallel ;-)
> M.

Do you think cpu wakeup alone could be doing this? If so, then doing
that bit would be relatively isolated (though a slightly larger diff
than changing an NMI oopser timeout).

Does 0xFF broadcast cluster, broadcast low nybble work or is waking
them a cluster at a time required?  This thing is not swift to boot...



Thanks,
Bill
