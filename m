Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbSKLIMK>; Tue, 12 Nov 2002 03:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbSKLIMK>; Tue, 12 Nov 2002 03:12:10 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:43411 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266285AbSKLIMJ>;
	Tue, 12 Nov 2002 03:12:09 -0500
Date: Tue, 12 Nov 2002 14:03:08 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: linux-kernel@vger.kernel.org, richard <richardj_moore@uk.ibm.com>
Subject: Re: Multiple kprobes per address
Message-ID: <20021112140308.A1055@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <200211082100.gA8L0Q515460@linux.intel.com> <20021111133548.A16731@in.ibm.com> <002e01c289b1$2c83b140$77d40a0a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002e01c289b1$2c83b140$77d40a0a@amr.corp.intel.com>; from rusty@linux.co.intel.com on Mon, Nov 11, 2002 at 10:35:56AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 10:35:56AM -0800, Rusty Lynch wrote:
> I was really only concerned with multiple consumers of kprobes.  So if
> I were to create some tool that used kpobes to hook into the kernel, and
> someone else were to create another tool that solved a different problem
> but also used kprobes then the two tools wouldn't play nice with each other.

There will be a problem when both the tools (built on top of kprobes) try
to place probes at the same address: only the first probe actually succeds,
the second one gets -EEXIST from register_kprobe.

This could be made to work, but at the moment, it seems unnecessary 
complication to me. Lets reconsider it when it really becomes a problem.

Thanks,
Vamsi. 
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
