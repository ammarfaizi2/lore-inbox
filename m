Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVBTD2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVBTD2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 22:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVBTD2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 22:28:42 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:31892 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261444AbVBTD2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 22:28:30 -0500
To: Scott Bronson <bronson@rinspin.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Getting the page size of currently running kernel
X-Message-Flag: Warning: May contain useful information
References: <200502191901.57425.bronson@rinspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 19 Feb 2005 19:28:27 -0800
In-Reply-To: <200502191901.57425.bronson@rinspin.com> (Scott Bronson's
 message of "Sat, 19 Feb 2005 19:01:57 -0800")
Message-ID: <521xbbucys.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Feb 2005 03:28:27.0885 (UTC) FILETIME=[3E11C9D0:01C516FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Scott> Is there any way to get a running kernel to tell you the
    Scott> size of its pages?  Why: I'm writing a quick Perl hack to
    Scott> monitor the memory usage of the TCP stack over time.  Easy
    Scott> enough: /proc/net/sockstat gives the current value of
    Scott> tcp_memory_allocated.  But how do I convert this into
    Scott> bytes?  I don't want to hard code PAGE_SIZE into my Perl
    Scott> script, complete with a lookup table for 4K vs. 8K
    Scott> architectures!  Am I missing something obvious here?

I'm not sure exactly how to call it from perl, but from C one can use
sysconf(3) like:

	page_size = sysconf(_SC_PAGESIZE);

(one can also use getpagesize(2) to do exactly the same thing)

 - R.
