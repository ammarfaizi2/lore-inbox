Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUCJLTW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUCJLTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:19:21 -0500
Received: from web10901.mail.yahoo.com ([216.136.131.37]:47 "HELO
	web10901.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262112AbUCJLTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:19:20 -0500
Message-ID: <20040310111919.83754.qmail@web10901.mail.yahoo.com>
Date: Wed, 10 Mar 2004 03:19:19 -0800 (PST)
From: Ashwin Rao <ashwin_s_rao@yahoo.com>
Subject: inconsistent do_gettimeofday for copy_page
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For calculating the time required to copy_page i tried
the do_gettimeofday for 1000 pages in a loop. But as
the number of pages changes the time required varies
non-linearly.
I also tried reading xtime and using monotonic_clock
but they didnt help either. For do_gettimeof day for a
single invocation of copy_page on a pentium 4 gave me
10 microsecs but when invoked for a 1000 pages the
time required was 750ns per page.
Is there some way of finding out the exact time
required for copying a page.

Ashwin

__________________________________
Do you Yahoo!?
Yahoo! Search - Find what you’re looking for faster
http://search.yahoo.com
