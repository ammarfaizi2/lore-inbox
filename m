Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316680AbSEQUaf>; Fri, 17 May 2002 16:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSEQUae>; Fri, 17 May 2002 16:30:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:19398 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316680AbSEQUad>; Fri, 17 May 2002 16:30:33 -0400
Date: Sat, 18 May 2002 02:03:57 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 16-CPU #s for lockfree rtcache (rt_rcu)
Message-ID: <20020518020357.B16829@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020517214433.A15556@in.ibm.com> <20020517.094624.68229633.davem@redhat.com> <m37km2vaoz.fsf@averell.firstfloor.org> <20020517.122519.102199743.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 12:25:19PM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@muc.de>
>    Date: 17 May 2002 21:25:16 +0200
> 
>    "David S. Miller" <davem@redhat.com> writes:
>    
>    > Provide the data, it will be interesting.
>    
>    I bet the numbers would be much better if the x86 
>    do_gettimeofday() was converted to a lockless version first ...
>    Currently it is bouncing around its readlock for every incoming packet.
> 
> That is true.  But right now we are trying to analyze the effects of
> his patch all by itself.

Yes, that is a another problem needs addressing.

BTW, do_gettimeofday() also shows up moderately significant in profile
of 8-CPU webserver benchmark. I will address xtime_lock separately.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
