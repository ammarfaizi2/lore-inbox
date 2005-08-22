Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVHVUwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVHVUwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHVUwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:52:18 -0400
Received: from fmr23.intel.com ([143.183.121.15]:44245 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751117AbVHVUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:52:17 -0400
Date: Mon, 22 Aug 2005 13:52:08 -0700
From: tony.luck@intel.com
Message-Id: <200508222052.j7MKq8c0020324@agluck-lia64.sc.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
In-Reply-To: <20050822105053.29667b61.akpm@osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>
	<20050821021322.3986dd4a.akpm@osdl.org>
	<200508221742.j7MHgMJI020020@agluck-lia64.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  we go there ... I'd like to hear whether there are usage models that
>>  really need better resolution than jiffies can provide?
>
>I think so.  Say you're debugging or performance tuning filesystem requests
>and I/O completions, etc.  You disable the console with `dmesg -n', run the
>test then do `dmesg -s 1000000 > foo'.  Having somewhat-sub-millisecond
>timestamping in the resulting trace is required.

That sounds like using a hammer to pound in screws ... it works,
but it might be a lot better to go find a screwdriver.

Couldn't you use kprobes to collect timestamps of interesting events
in your filesystem instead of splashing printk() all over the place?

But perhaps this is heresy, real kernel programmers do all their
debugging with printk() :-)

-Tony
