Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSIEJBd>; Thu, 5 Sep 2002 05:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSIEJBd>; Thu, 5 Sep 2002 05:01:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20931 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317349AbSIEJBc>;
	Thu, 5 Sep 2002 05:01:32 -0400
Date: Thu, 5 Sep 2002 14:40:23 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: rusty@rustcorp.com.au
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Dave Miller <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Important per-cpu fix.
Message-ID: <20020905144023.A14040@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20020904023535.73D922C12D@lists.samba.org> Rusty Russell wrote:
> Frankly, I'm amazed the kernel worked for long without this.

> Every linker script thinks the section is called .data.percpu.
> Without this patch, every CPU ends up sharing the same "per-cpu"
> variable.

> This might explain the wierd per-cpu problem reports from Andrew and
> Dave, and also that nagging feeling that I'm an idiot...

Not only does this fix the tasklet BUG with 2.5.32 but it also fixes a serial
console hang with my 2.5.32 version of Ingo/Davem/Alexey's scalable timers 
code that I have been debugging for the last two days. I use
a per-cpu tasklet to run the timers, so it was probably killing me
there.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
