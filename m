Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269608AbUKASrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269608AbUKASrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275495AbUKASrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 13:47:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5068 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S285787AbUKAS0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 13:26:45 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Buffered I/O slowness
Date: Mon, 1 Nov 2004 10:26:34 -0800
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, jeremy@sgi.com
References: <200410251814.23273.jbarnes@engr.sgi.com> <200410291716.25277.jbarnes@engr.sgi.com> <20041029173045.32722ac0.akpm@osdl.org>
In-Reply-To: <20041029173045.32722ac0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411011026.34102.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 29, 2004 5:30 pm, Andrew Morton wrote:
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > I'm not sure that we know what's going on yet.  I certainly don't.  The
> > > above numbers look good, so what's the problem???
> >
> > The numbers are ~1/3 of what the machine is capable of with direct I/O.
>
> Are there CPU cycles to spare?  If you have just one CPU copying 1GB/sec
> out of pagecache, maybe it is pegged?

Hm, I thought I had more CPU to spare, but when I set the readahead to a large 
value, I'm taking ~100% of the CPU time on the CPU doing the read.  ~98% of 
that is system time.  When I run 8 copies (this is an 8 CPU system), I get 
~4GB/s and all the CPUs are near fully busy.  I guess things aren't as bad as 
I initially thought.

Thanks,
Jesse
