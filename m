Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVBTC7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVBTC7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 21:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBTC7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 21:59:39 -0500
Received: from adsl-64-161-106-9.dsl.snfc21.pacbell.net ([64.161.106.9]:5320
	"EHLO eden.trestle.com") by vger.kernel.org with ESMTP
	id S261400AbVBTC7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 21:59:35 -0500
From: Scott Bronson <bronson@rinspin.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Getting the page size of currently running kernel
Date: Sat, 19 Feb 2005 19:01:57 -0800
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502191901.57425.bronson@rinspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to get a running kernel to tell you the size of its pages?

Why: I'm writing a quick Perl hack to monitor the memory usage of the TCP 
stack over time.  Easy enough: /proc/net/sockstat gives the current value of 
tcp_memory_allocated.  But how do I convert this into bytes?  I don't want to 
hard code PAGE_SIZE into my Perl script, complete with a lookup table for 4K 
vs. 8K architectures!  Am I missing something obvious here?

Thanks,

    - Scott

