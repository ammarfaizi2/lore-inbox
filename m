Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVGZSQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVGZSQv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGZSOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:14:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262006AbVGZSMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:12:23 -0400
Date: Tue, 26 Jul 2005 11:11:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726111110.6b9db241.akpm@osdl.org>
In-Reply-To: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> After KS & OLS discussions about memory pressure, I wanted to re-do
>  iSCSI testing with "dd"s to see if we are throttling writes.  
> 
>  I created 50 10-GB ext3 filesystems on iSCSI luns. Test is simple
>  50 dds (one per filesystem). System seems to throttle memory properly
>  and making progress. (Machine doesn't respond very well for anything
>  else, but my vmstat keeps running - 100% sys time).

It's important to monitor /proc/meminfo too - the amount of dirty/writeback
pages, etc.

btw, 100% system time is quite appalling.  Are you sure vmstat is telling
the truth?  If so, where's it all being spent?

