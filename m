Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVCLBWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVCLBWf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 20:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVCLBWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 20:22:35 -0500
Received: from fire.osdl.org ([65.172.181.4]:24196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261822AbVCLBWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 20:22:30 -0500
Date: Fri, 11 Mar 2005 17:22:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Prefaulting
Message-Id: <20050311172228.773cf03d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110444220.19419@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> This patch allows to aggregate multiple page faults into a single one. It
> does that by detecting that an application generates a sequence of page
> faults.
> 
> ...
> Results that show the impact of this patch are available at
> http://oss.sgi.com/projects/page_fault_performance/

There are a lot of numbers there.  Was there an executive summary?

>From a quick peek it seems that the patch makes negligible difference for a
kernel compilation when prefaulting 1-2 pages and slows the workload down
quite a lot when prefaulting up to 16 pages.

And for the uniprocessor "200 Megabyte allocation without prezeroing. 
Single thread." workload it appears that the prefault patch slowed it down
by 4x.

Am I misreading the results?  If not, it's a bit disappointing.
