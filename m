Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136614AbREJN7o>; Thu, 10 May 2001 09:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136635AbREJN7h>; Thu, 10 May 2001 09:59:37 -0400
Received: from zeus.kernel.org ([209.10.41.242]:54674 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136640AbREJN7X>;
	Thu, 10 May 2001 09:59:23 -0400
Date: Thu, 10 May 2001 10:21:05 +0530
From: Maneesh Soni <smaneesh@sequent.com>
To: "Andrew M. Theurer" <atheurer@austin.ibm.com>
Cc: lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: [Lse-tech] Re: Linux 2.4 Scalability, Samba, and Netbench
Message-ID: <20010510102105.B5470@in.ibm.com>
Reply-To: smaneesh@sequent.com
In-Reply-To: <3AF97062.42465A53@austin.ibm.com> <20010509095658.B1150@w-mikek2.sequent.com> <3AF97EBB.9F0ABE9A@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF97EBB.9F0ABE9A@austin.ibm.com>; from atheurer@austin.ibm.com on Wed, May 09, 2001 at 12:30:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 12:30:35PM -0500, Andrew M. Theurer wrote:
> I do have kernprof ACG and lockmeter for a 4P run.  We saw no
> significant problems with lockmeter.  csum_partial_copy_generic was the
> highest % in profile, at 4.34%.  I'll see if we can get some space on
> http://lse.sourceforge.net to post the test data.
> 
> Andrew Theurer
> 
> Mike Kravetz wrote:
> > 
> > On Wed, May 09, 2001 at 11:29:22AM -0500, Andrew M. Theurer wrote:
> > >
> > > I am evaluating Linux 2.4 SMP scalability, using Netbench(r) as a
> > > workload with Samba, and I wanted to get some feedback on results so
> > > far.
> > 
> > Do you have any kernel profile or lock contention data?
> > 
> > --
> > Mike Kravetz                                 mkravetz@sequent.com
> > IBM Linux Technology Center

Hello Andrew,

If in the kernprof data you find "fget" as one of the high rankers (say in top
10) then can you try the scalable FD management patch which uses 
read-copy-update mechanism for protecting files_struct. 

As of now there are working patches available for read-copy-update mechanism 
and FD management at "http://lse.sourceforge.net/locking/rclock.html" as 
rclock-2.4.2-01.patch and files_struct_rcu-2.4.2-03.patch but we are working on 
simpler interfaces. Also let me know if you need the patches for a different 
2.4 kernel version.

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center,
IBM India Software Lab, Bangalore.
email: smaneesh@sequent.com
http://lse.sourceforge.net/locking/rclock.html
