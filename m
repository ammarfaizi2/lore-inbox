Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVBTDXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVBTDXl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 22:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVBTDXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 22:23:40 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:13450 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261473AbVBTDWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 22:22:44 -0500
Date: Sun, 20 Feb 2005 05:22:43 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: Getting the page size of currently running kernel
In-reply-to: <200502191901.57425.bronson@rinspin.com>
To: Scott Bronson <bronson@rinspin.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-id: <200502200522.43321.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200502191901.57425.bronson@rinspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 February 2005 05:01, Scott Bronson wrote:
> Is there any way to get a running kernel to tell you the size of its pages?
> 
> Why: I'm writing a quick Perl hack to monitor the memory usage of the TCP 
> stack over time.  Easy enough: /proc/net/sockstat gives the current value of 
> tcp_memory_allocated.  But how do I convert this into bytes?  I don't want to 
> hard code PAGE_SIZE into my Perl script, complete with a lookup table for 4K 
> vs. 8K architectures!  Am I missing something obvious here?

Can you call functions in glibc through perl?
If so, then getpagesize(2) is what you're looking for.
Can you do raw syscalls in perl, if so, you could get the same info that way.

