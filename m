Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWIKCcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWIKCcp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 22:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWIKCcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 22:32:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751053AbWIKCco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 22:32:44 -0400
Date: Sun, 10 Sep 2006 22:39:50 -0400
From: Dave Jones <davej@redhat.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cache line size
Message-ID: <20060911023950.GF4743@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	John Richard Moser <nigelenki@comcast.net>,
	linux-kernel@vger.kernel.org
References: <4504AF26.9040807@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4504AF26.9040807@comcast.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2006 at 08:34:46PM -0400, John Richard Moser wrote:
 
 > Is there a way for the Linux Kernel to know the cache line size of the
 > CPU it's on, besides #define X86_CACHE_LINE_SZ 32 or whatnot?  I am
 > looking in /proc/cpuinfo trying to determine how to run caching
 > optimizations and interested in this information and its implications.
 > It may also be useful if I can get this information at run time in
 > application code.

You can use /dev/cpu/x/cpuid to read it directly from the CPU.
See the source of x86info for examples.

	Dave
