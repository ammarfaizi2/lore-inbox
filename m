Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267971AbUJOCYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267971AbUJOCYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUJOCYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:24:24 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:62994 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267971AbUJOCYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:24:17 -0400
Date: Thu, 14 Oct 2004 19:23:41 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U2
Message-ID: <20041015022341.GA22831@nietzsche.lynx.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014234202.GA26207@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 01:42:02AM +0200, Ingo Molnar wrote:
> 
> i have released the -U2 PREEMPT_REALTIME patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U2

mm/shmem.c: In function `shmem_dir_map':
mm/shmem.c:103: warning: implicit declaration of function `kmap_atomic_rt'
mm/shmem.c:103: error: `KM_USER0' undeclared (first use in this function)
mm/shmem.c:103: error: (Each undeclared identifier is reported only once
mm/shmem.c:103: error: for each function it appears in.)
mm/shmem.c: In function `shmem_dir_unmap':
mm/shmem.c:108: warning: implicit declaration of function `kunmap_atomic_rt'
mm/shmem.c:108: error: `KM_USER0' undeclared (first use in this function)
mm/shmem.c: In function `shmem_swp_map':
mm/shmem.c:113: error: `KM_USER1' undeclared (first use in this function)
mm/shmem.c: In function `shmem_swp_balance_unmap':
mm/shmem.c:125: error: `KM_USER1' undeclared (first use in this function)
mm/shmem.c: In function `shmem_swp_unmap':
mm/shmem.c:130: error: `KM_USER1' undeclared (first use in this function)
mm/shmem.c: In function `shmem_swp_set':
mm/shmem.c:333: warning: implicit declaration of function `kmap_atomic_to_page_rt'
mm/shmem.c:333: error: invalid type argument of `->'
mm/shmem.c: In function `shmem_file_write':
mm/shmem.c:1362: error: `KM_USER0' undeclared (first use in this function)
mm/shmem.c:1362: warning: assignment makes pointer from integer without a cast
mm/shmem.c: In function `shmem_symlink':
mm/shmem.c:1719: error: `KM_USER0' undeclared (first use in this function)
mm/shmem.c:1719: warning: assignment makes pointer from integer without a cast
make[1]: *** [mm/shmem.o] Error 1
make: *** [mm] Error 2
root@nietzsche> /home/bhuey/linux-2.6.8% 17# make tags

....

I've got kgdb targetted next and I'm trying to figure out how to write a
rw/semaphore with priority inheritance.

bill

