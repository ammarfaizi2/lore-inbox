Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWI3RTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWI3RTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWI3RTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:19:31 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:54174 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S1751314AbWI3RTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:19:31 -0400
To: rmk+lkml@arm.linux.org.uk
CC: James.Bottomley@steeleye.com, dhylands@gmail.com, guinan@bluebutton.com,
       linux-kernel@vger.kernel.org
In-reply-to: <20060930170548.GA24949@flint.arm.linux.org.uk> (message from
	Russell King on Sat, 30 Sep 2006 18:05:48 +0100)
Subject: Re: get_user_pages() cache issues on ARM
References: <E1GTiBq-0002i3-00@dorka.pomaz.szeredi.hu> <20060930170548.GA24949@flint.arm.linux.org.uk>
Message-Id: <E1GTiTy-0002kU-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Sep 2006 19:18:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added James Bottomley to the CC.  He designed this interface, and he
explained to me how it's supposed to work, but I since forgot.

James, do you have some memory of these issues?

Thanks,
Miklos

> > Hi Russell,
> > 
> > The get_user_pages() vs dcache coherency issue still seems to be
> > unresolved on ARM.
> > 
> > See flush_anon_page() and flush_kernel_dcache_page() in
> > Documentation/cachetlb.txt and their implementation on PARISC.
> > 
> > Can you please take a look at this?
> 
> I'm sorry, I don't think I have sufficient understanding of the Linux VM
> to look at these issues anymore.
> 
> The questions I have are:
> 
> - where do these pages that get_user_pages() finds and calls flush_anon_page()
>   on come from?
> - why is the current ARM flush_dcache_page() (which is also called after
>   flush_anon_page()) not sufficient?
> - if we implement flush_anon_page() does that mean that we end up flushing
>   multiple times in some circumstances?  If so, how do we avoid this?
> 
> I'm really serious - I no longer understand the Linux VM sufficiently to
> get this stuff right.
