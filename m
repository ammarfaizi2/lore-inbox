Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318882AbSHANhG>; Thu, 1 Aug 2002 09:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318893AbSHANhG>; Thu, 1 Aug 2002 09:37:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:50172 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318882AbSHANhF>; Thu, 1 Aug 2002 09:37:05 -0400
Date: Thu, 1 Aug 2002 19:14:46 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Mala Anand <manand@us.ibm.com>
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
Message-ID: <20020801191446.D32256@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OF6D440764.727DFE3C-ON87256C08.0049B06D@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF6D440764.727DFE3C-ON87256C08.0049B06D@boulder.ibm.com>; from manand@us.ibm.com on Thu, Aug 01, 2002 at 08:31:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 08:31:45AM -0500, Mala Anand wrote:
> 
> Dipankar wrote..
> >Isn't it possible to tune the cpucache limit by writing to
> >/proc/slabinfo so that you avoid frequent draining of free objects ?
> >Am I missing something here ?
> 
> Are you referring to raising the per cpu array limit? I don't think you
> tune that using /proc/slabinfo.  However that does not solve the problem,

Hmm... then what does slabinfo_write()->kmem_tune_cpucache() do ?

> it only delays it.  It needs to grow/shrink dynamically based on need. I
> am not only referring to frequently draining of free objects but also
> as a result of this refilling the object array due to subsequent
> allocations and so on.

If draining of free objects become rare, shouldn't refilling of the
object also become rare ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
