Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbVC2JQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVC2JQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 04:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVC2JQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 04:16:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:48828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262271AbVC2JQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 04:16:12 -0500
Date: Tue, 29 Mar 2005 01:15:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: davej@redhat.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimization: defer bio_vec deallocation
Message-Id: <20050329011547.249167e7.akpm@osdl.org>
In-Reply-To: <200503290307.j2T37Yg25879@unix-os.sc.intel.com>
References: <20050329025932.GC435@redhat.com>
	<200503290307.j2T37Yg25879@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> On Mon, Mar 28, 2005 at 06:38:23PM -0800, Chen, Kenneth W wrote:
>  > We have measured that the following patch give measurable performance gain
>  > for industry standard db benchmark.  Comments?
> 
>  Dave Jones wrote on Monday, March 28, 2005 7:00 PM
>  > If you can't publish results from that certain benchmark due its stupid
>  > restrictions, could you also try running an alternative benchmark that
>  > you can show results from ?
>  >
>  > These nebulous claims of 'measurable gains' could mean anything.
>  > I'm assuming you see a substantial increase in throughput, but
>  > how much is it worth in exchange for complicating the code?
> 
>  Are you asking for micro-benchmark result?

There are a number of test tools floating about.  reaim, orasim, osdb, others.

A number of them are fairly crufty and toy-like, but still more useful than
microbenchmarks, and they permit others to evaluate patches and to perform
further optimisation. 

It's in everyone's interest that we get away from a test which has such
dopey restrictions.
