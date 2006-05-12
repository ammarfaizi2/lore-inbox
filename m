Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWELMUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWELMUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWELMUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:20:41 -0400
Received: from [83.101.156.218] ([83.101.156.218]:523 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751261AbWELMUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:20:40 -0400
From: Al Boldi <a1426z@gawab.com>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: swapping and oom-killer: gfp_mask=0x201d2, order=0
Date: Fri, 12 May 2006 15:17:59 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200605111514.45503.a1426z@gawab.com> <1147412910.8432.14.camel@homer>
In-Reply-To: <1147412910.8432.14.camel@homer>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200605121517.59988.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Thu, 2006-05-11 at 15:14 +0300, Al Boldi wrote:
> > The current mm behaviour in 2.6, during physical memory exhaustion,
> > expresses itself as an oom-killing spree, while the kernel could have
> > resorted to swapping.
> >
> > Is there a reason why oom-killing is currently preferred over swapping?
>
> Looks to me like you booted with mem=8m, and these allocations are
> failing because every page the page allocator tried to issue were marked
> as being reserved.  The SysRq-M output shows that it did try to swap as
> it limped along.
>
> My box won't get past a black screen hang with less than mem=24m, so I'm
> kinda surprised you got far enough to even add swap.

The thing is, that it boots nicely into init=/bin/sh, and even runs top and 
mc w/o a hitch, but when another bash is started the kernel starts to oom 
everything, when in fact it should have easily been able to swap.

Note that this is not specific to mem=8M, but rather a general oom 
observation even for mem=4G, where it is only much later to occur.

Thanks!

--
Al

