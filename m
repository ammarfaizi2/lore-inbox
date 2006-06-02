Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWFBS7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWFBS7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWFBS7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:59:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23531 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbWFBS7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:59:21 -0400
Date: Fri, 2 Jun 2006 11:59:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060602115911.bcfe2654.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606021902340.31071@skynet.skynet.ie>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<Pine.LNX.4.64.0606021902340.31071@skynet.skynet.ie>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006 19:38:36 +0100 (IST)
Mel Gorman <mel@csn.ul.ie> wrote:

> This reliably goes kablam on an x86_64 machine with a tg3 network card 
> which was also happening for 2.6.17-rc5-mm1. A patch bisect found that 
> reversing git-net.patch and git-net-git-klibc-fixup.patch on top of 
> the -mm3 got rid of the problem. Don't ask me why.
> 
> The console log I have of the most common oops is below and the .config 
> used is attached. The oops happens reliably but at varying times and not 
> always the same oops either. Usually sshing into the machine and compiling 
> the kernel is enough. On at least one occasion, sshing to the machine 
> triggered it.

Yeah, sorry.  I _knew_ LLC was buggy but I forgot to mention it in the
release notes and wasted heaps of lots of people's time.  Feel free to
bill me :(

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/hot-fixes/git-net-llc-fix.patch

should fix.
