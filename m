Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVA1A4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVA1A4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVA1A4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:56:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56291 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261347AbVA1Axs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:53:48 -0500
Date: Thu, 27 Jan 2005 16:53:30 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: mingo@elte.hu, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
Message-Id: <20050127165330.6f388054.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
References: <20041116113209.GA1890@elte.hu>
	<419A7D09.4080001@bigpond.net.au>
	<20041116232827.GA842@elte.hu>
	<Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A long time ago, Linus wrote:
> An atomic op is pretty much as expensive as a spinlock/unlock pair on x86.  
> Not _quite_, but it's pretty close.

Are both read and modify atomic ops relatively expensive on some CPUs,
or is it just modify atomic ops?

(Ignoring for this question the possibility that a mix of read and
modify ops could heat up a cache line on multiprocessor systems, and
focusing for the moment just on the CPU internals ...)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
