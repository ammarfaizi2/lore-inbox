Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSKKHop>; Mon, 11 Nov 2002 02:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSKKHop>; Mon, 11 Nov 2002 02:44:45 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45440 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265649AbSKKHoo>;
	Mon, 11 Nov 2002 02:44:44 -0500
Date: Mon, 11 Nov 2002 13:35:49 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple kprobes per address
Message-ID: <20021111133548.A16731@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <200211082100.gA8L0Q515460@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200211082100.gA8L0Q515460@linux.intel.com>; from rusty@linux.co.intel.com on Fri, Nov 08, 2002 at 01:00:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 08, 2002 at 01:00:26PM -0800, Rusty Lynch wrote:
> I noticed that kprobes is designed around the idea of only allowing
> a single probe point per probe address.  Why not allow multiple probe
> points for a given probe address?  Is it a way of limiting complexity?
> 
We didn't think it would be useful and conceptually, it is simpler to
think of one probe at an address.

> It looks like it would be fairly straight forward to change get_kprobe(addr)
> to be get_kprobes(addr) where it returns a list of probe points associated
> with the address, and then tweak do_int3 to work through the entire list.
> Would such a change be acceptable?
> 
It will be trivial to add this, but why? Is there a good reason
for wanting to do this (multiple kprobes at same address) as opposed 
to doing all you want done on a probe hit in a single handler?

Regards,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
