Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWC0UUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWC0UUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 15:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWC0UUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 15:20:06 -0500
Received: from fmr17.intel.com ([134.134.136.16]:34994 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751120AbWC0UUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 15:20:04 -0500
Message-ID: <442848EF.4000407@ichips.intel.com>
Date: Mon, 27 Mar 2006 12:19:59 -0800
From: Sean Hefty <mshefty@ichips.intel.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
References: <ada7j6f8xwi.fsf@cisco.com>
In-Reply-To: <ada7j6f8xwi.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>    - Working around the IB midlayer SMA (subnet management agent) /
>      implementation with a character device when ib_mad isn't loaded.
>      Maybe I'm off-base here objecting to this.  Hal and Sean, as the
>      ib_mad guys, I'd be especially interested in your opinion of this.

I will need to spend some time reading through the PathScale code on this.  I've 
  followed most of the discussion, though not in detail.  Right now, I don't see 
what's being gained by not loading ib_mad.  For instance, how does the driver 
handle loading ib_mad later, say when another IB device is added to the system 
that requires it?

>  * RDMA CM.  In my git tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband.git rdma_cm
> 
>    I think this is OK to merge, but I don't see much pull to get it in
>    right now.  There are three consumers on the horizon:
> 
>    - userspace RDMA CM, which exports the abstraction to userspace.
>      The feeling is that this interface needs more time to mature.
> 
>    - NFS/RDMA.  Not ready to merge right now.
> 
>    - iSER.  Maybe ready to merge -- I haven't heard anything recently.

I agree that we need to let the userspace interface mature.  And even the kernel 
interface could benefit from having some real users.  The code was added to the 
-mm branch, correct?

The main drawback that we have not merging the RDMA CM with userspace support, 
is that OpenIB release 1.0 will have very poor connection management support. 
There's no easy way for userspace applications to obtain path records.

- Sean
