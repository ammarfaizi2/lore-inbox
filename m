Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264881AbSKEP6S>; Tue, 5 Nov 2002 10:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264882AbSKEP6S>; Tue, 5 Nov 2002 10:58:18 -0500
Received: from [202.88.171.30] ([202.88.171.30]:7074 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S264881AbSKEP6R>;
	Tue, 5 Nov 2002 10:58:17 -0500
Date: Tue, 5 Nov 2002 21:30:46 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Ravikiran G Thirumalai <kiran@in.ibm.com>, akpm@zip.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kmalloc_percpu
Message-ID: <20021105213046.B10886@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021031213640.D2298@in.ibm.com> <20021101193354.54367ba4.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021101193354.54367ba4.rusty@rustcorp.com.au>; from rusty@rustcorp.com.au on Fri, Nov 01, 2002 at 07:33:54PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 07:33:54PM +1100, Rusty Russell wrote:
> On Thu, 31 Oct 2002 21:36:40 +0530
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> 
> > Here's  kmalloc_percpu interfaces ported (...mostly rediffed) to 
> > 2.5.45.  (One last try for 2.6).
> 
> IMHO this is a "when we need it" patch.  Baby steps...

Agreed. It could be useful if we want to use per-CPU statistics
for things like disk I/O (now in struct gendisk).

> 
> > +#define this_cpu_ptr(ptr) per_cpu_ptr(ptr, smp_processor_id())
> 
> Probably want a get_cpu_ptr() & put_cpu_ptr() using get_cpu() and put_cpu()
> (and this would become __get_cpu_ptr()).
> 
> And probably move them all to linux/percpu.h.

Yes, it needs to sync up with its static twin ;-)

Thanks
Dipankar
