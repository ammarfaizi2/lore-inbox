Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVCaHqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVCaHqG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVCaHnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:43:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:23203 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262546AbVCaHlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:41:47 -0500
Date: Wed, 30 Mar 2005 23:41:33 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
Message-Id: <20050330234133.59fdafdf.pj@engr.sgi.com>
In-Reply-To: <424B7ECD.6040905@shaw.ca>
References: <3NTHD-8ih-1@gated-at.bofh.it>
	<424B7ECD.6040905@shaw.ca>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup - kills my x86_64 too.  I can't stay up for half a minute.
I got a couple of Oops

  Unable to handle kernel paging request at 0000000000002730 RIP:

  Unable to handle kernel paging request at ffff81773ffc6918 RIP:

The first try ended with a sudden reboot.  The second time, I ctrl-C'd
out while I still had a responsive system.

I thought it might be a CPU temperature issue, so downloaded XMBmon
"Mother Board Monitor Program for X Window System", and hacked the
command line mbmon in it to add this memset loop and report the CPU temp
each time around the loop.

My CPU Temp went from its usual 39 C idle, to 45 C during the memset
loop, which are typical temperatures for this PC.  No problem there.

In a couple more tries, I got:
  knotify killed with a SIGSEGV
  artsd killed with a SIGSEGV
  a hard lockup, requiring the big red button
  a second oops at the same ffff81773ffc6918 as above.

My CPU, from /proc/cpuinfo, is:
model name      : AMD Athlon(tm) 64 Processor 3500+

My mainboard is an MSI K8N Neo2 Platinum.  I have 1 GByte of
Corsair XMS DDR400 memory.

I am not overclocking and I am running with standard voltages.

This is on a 2.6.11-rc5 kernel, though I doubt that matters.
I'm guessing it's hardware.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
