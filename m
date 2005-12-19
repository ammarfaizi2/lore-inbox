Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVLSQj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVLSQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVLSQj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:39:56 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50357 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964833AbVLSQjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:39:55 -0500
Date: Mon, 19 Dec 2005 10:39:30 -0600
From: Greg Edwards <edwardsg@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: paulmck@us.ibm.com, akpm@osdl.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: CONFIG_DEBUG_PREEMPT (was: [PATCH 04/04] Cpuset: skip rcu check ...)
Message-ID: <20051219163930.GG1320@sgi.com>
References: <20051214084031.21054.13829.sendpatchset@jackhammer.engr.sgi.com> <20051214084049.21054.34108.sendpatchset@jackhammer.engr.sgi.com> <20051216175201.GA24876@us.ibm.com> <20051216120651.cb57ad2e.pj@sgi.com> <20051217164723.GA28255@us.ibm.com> <20051219064810.0ec403ee.pj@sgi.com> <20051219080401.861acca2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219080401.861acca2.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2005 at 08:04:01AM -0800, Paul Jackson wrote:
| Greg - CONFIG_DEBUG_PREEMPT adds a couple of pages of assembly code 
| due to various BUG checks beneath rcu_read_lock() on some hot code
| paths (which is where rcu is most popular).  See the two calls
| add_preempt_count() and sub_preempt_count() in kernel/sched.c.
| 
| Was this intentional to enable CONFIG_DEBUG_PREEMPT in sn2_defconfig?

It wasn't intentional at the time.  I believe it was pulled in
automatically when we refreshed since we had CONFIG_PREEMPT on.  That
said, it has proven itself useful in turning up some bugs.

Greg
