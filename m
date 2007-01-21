Return-Path: <linux-kernel-owner+w=401wt.eu-S1750984AbXAUAkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbXAUAkp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 19:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbXAUAkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 19:40:45 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:39660 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbXAUAkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 19:40:45 -0500
Date: Sun, 21 Jan 2007 00:14:58 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: sathesh babu <sathesh_edara2003@yahoo.co.in>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Running Linux on FPGA
Message-ID: <20070121001457.GA9123@linux-mips.org>
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 11:42:37PM +0000, sathesh babu wrote:

> Hi,
>   I am trying to run Linux-2.6.18.2 ( with preemption enable) kernel on FPGA board which has MIPS24KE processor runs at 12 MHZ. Programmed the timer to give interrupt at every 10msec.
>   I am seeing some inconsistence behavior during boot up processor. Some times it stops after "NET: Registered protocol family 17" and "VFS: Mounted root (jffs2 filesystem).".
>   Could some give some pointers why the behavior is random.
>   Is it OK to program the timer to 10 msec? or should it be more.

The overhead of timer interrupts at this low clockrate is significant
so I recommend to minimize the timer interrupt rate as far as possible.
This is really a tradeoff between latency and overhead and matters
much less on hardcores which run at hundreds of MHz.  For power sensitive
applications lowering the interrupt rate can also help.  And that's alredy
pretty much what you need to know, that is a 10ms  timer is fine.

Btw, is this coincidentally on a CoreFPGA 2 or 3 CPU card on a Malta board?

  Ralf
