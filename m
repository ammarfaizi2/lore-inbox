Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWFPQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWFPQVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWFPQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:21:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751478AbWFPQVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:21:39 -0400
Date: Fri, 16 Jun 2006 12:18:06 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, eranian@hpl.hp.com,
       linux-kernel@vger.kernel.org, systemtap@sources.redhat.com,
       wcohen@redhat.com, perfmon@napali.hpl.hp.com
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
Message-ID: <20060616161806.GI30867@redhat.com>
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com> <20060616135014.GB12657@infradead.org> <20060616140234.GI10034@frankl.hpl.hp.com> <y0mhd2lumz7.fsf@ton.toronto.redhat.com> <20060616154519.GA28931@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616154519.GA28931@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

> > Whether one uses systemtap, raw kprobes, or some specialized
> > tracing/stats-collecting patch surely forthcoming, kernel-level APIs
> > would be needed to perform fine-grained kernel-scope measurements
> > using these counters.
> 
> No, there's not need to add kernel bloat for performance monitoring.
> This kind of stuff shoul dabsolutely be done from userspace.

Userspace measurements provide only large-grained quantities.  Can you
argue convincingly that there is never a need to measure focused
quantities such as cache behaviors of individual subsystems, branch
prediction statistics of a new algorithm?  That running system-level
benchmarks is the most efficient way for developers to assess their
changes?  That the scheduler would not benefit from access to HT
resource utilization statistics?  All these sorts of efforts seem
to require a kernel-side perfmon API.

- FChE
