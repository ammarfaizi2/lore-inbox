Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWDLX2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWDLX2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 19:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWDLX2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 19:28:01 -0400
Received: from xenotime.net ([66.160.160.81]:26246 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932405AbWDLX2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 19:28:00 -0400
Date: Wed, 12 Apr 2006 16:30:25 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: hzy@cs.otago.ac.nz
Cc: zhiyi6@xtra.co.nz, penberg@cs.helsinki.fi, hnagar2@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab corruption after unloading a module
Message-Id: <20060412163025.17e36238.rdunlap@xenotime.net>
In-Reply-To: <20060412230439.WMCC8268.mta4-rme.xtra.co.nz@[202.27.184.228]>
References: <20060412230439.WMCC8268.mta4-rme.xtra.co.nz@[202.27.184.228]>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2006 11:04:39 +1200 Zhiyi Huang wrote:

> > 2.6.8 is an old kernel, you could very well be hitting a kernel bug
> > that has been fixed already. Can you reproduce this with 2.6.16? 
> 
> I will try that soon.
> 
> > Also,
> > you're not including sources to your module so it's impossible to tell
> > whether you're doing something wrong.
> > 
> >                                                          Pekka
> 
> Below is my baby module which only uses kmalloc and kfree for my device 
> structure. I found the slab corruption address is the address of the structure. 
> It seems to be a bug for kmalloc and kfree.

I haven't looked at your source code yet, but in addition to testing with a
recent kernel version, it may help to enable lots of kernel debug options.
Could you try that too, or do you already do that?

---
~Randy
