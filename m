Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUASWWu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbUASWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:22:50 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:27804 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264246AbUASWWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:22:48 -0500
Date: Mon, 19 Jan 2004 14:22:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Paolo Ornati <ornati@lycos.it>
Cc: J?rgen Urban <jur@sysgo.com>, linux-kernel@vger.kernel.org
Subject: Re: Lost memory, total memory size is not correct
Message-ID: <20040119222229.GU1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Paolo Ornati <ornati@lycos.it>,
	J?rgen Urban <jur@sysgo.com>, linux-kernel@vger.kernel.org
References: <200401191222.23449.jur@sysgo.com> <200401191845.58901.ornati@lycos.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401191845.58901.ornati@lycos.it>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 06:58:05PM +0100, Paolo Ornati wrote:
> On Monday 19 January 2004 12:22, J?rgen Urban wrote:
> > Hello,
> >
> > I tried to get the amount of total physical memory. I looked at
> > /proc/meminfo and found this line (2.4.18):
> >
> > MemTotal:        30844 kB
> >
> > But this is not correct the system have 32768 kB Memory. I looked at
> > kernel sources and I found the variable max_mapnr. Can I use it to detect
> > the correct memory size? It seems that it stores the maximum number of
> > pages usable. So I can convert it with macro K() in
> > linux/fs/proc/proc_misc.c to a value in kB.
> 
> There are some addresses that cannot be used on PC because there is 
> something mapped (for example System ROM...), you can see these regions 
> doing "cat /proc/iomem".

That's usually just a few KB, but don't forget that MemTotal is what's left
after kernel memory is mapped.
