Return-Path: <linux-kernel-owner+w=401wt.eu-S1752011AbXAQEVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbXAQEVN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 23:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXAQEVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 23:21:13 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59719 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752011AbXAQEVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 23:21:12 -0500
Date: Tue, 16 Jan 2007 20:20:56 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: clameter@sgi.com, akpm@osdl.org, menage@google.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, dgc@sgi.com
Subject: Re: [RFC 5/8] Make writeout during reclaim cpuset aware
Message-Id: <20070116202056.075c4c03.pj@sgi.com>
In-Reply-To: <200701170907.14670.ak@suse.de>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116054809.15358.22246.sendpatchset@schroedinger.engr.sgi.com>
	<200701170907.14670.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> Is there a reason this can't be just done by node, ignoring the cpusets?

This suggestion doesn't make a whole lot of sense to me.

We're looking to see if a task has dirtied most of the
pages in the nodes it is allowed to use.  If it has, then
we want to start pushing pages to the disk harder, and
slowing down the tasks writes.

What would it mean to do this per-node?  And why would
that be better?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
