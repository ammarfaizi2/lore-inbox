Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313550AbSDQLNa>; Wed, 17 Apr 2002 07:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313551AbSDQLN3>; Wed, 17 Apr 2002 07:13:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:56055 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313550AbSDQLN2>;
	Wed, 17 Apr 2002 07:13:28 -0400
Date: Wed, 17 Apr 2002 12:45:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 fix for percpu area
Message-ID: <20020417124559.B16082@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020416125716.A31123@in.ibm.com> <E16xjNw-0001A5-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 04:57:44PM +1000, Rusty Russell wrote:
> In message <20020416125716.A31123@in.ibm.com> you write:
> > The percpu area stuff is broken in two places -
> > 
> > Missing stub for setup_per_cpu_areas() in the UP case
> > and missing definition of __per_cpu_data attribute in percpu.h.
> > Here is a patch that fixes these. Please apply.
> 
> You should be including "linux/percpu.h" which defines __per_cpu_data
> for UP.

I didn't know that existed. This works.

> 
> The other fix is to move the whole #ifdef __GENERIC_PER_CPU
> ... setup_per_cpu_areas(void) { ...#endif out from inside the #ifdef
> CONFIG_SMP block (patch sent).

Ok. I will make a new patch for my own use until you fix gets included.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
