Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135264AbRDZJyc>; Thu, 26 Apr 2001 05:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135273AbRDZJyW>; Thu, 26 Apr 2001 05:54:22 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:44299 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S135264AbRDZJyH>; Thu, 26 Apr 2001 05:54:07 -0400
Date: Thu, 26 Apr 2001 02:53:56 -0700
Message-Id: <200104260953.f3Q9rui03376@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: <linux-kernel@vger.kernel.org>, apark@cdf.toronto.edu
Subject: Re: 2.2.19 and file lock on NFS?
In-Reply-To: <shsvgntkjm8.fsf@charged.uio.no>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Apr 2001 00:39:43 +0200, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>>>>>> " " == apark  <apark@cdf.toronto.edu> writes:
> 
>     > Hi, Recently upgraded to 2.2.19, along with new
>     > nfs-utils(0.3.1).  But I have a program that requires a
>     > exclusive write lock on a NFSed directory.  When I was using
>     > 2.2.17 all was ok, but now it returns ENOLCK.  Does anybody
>     > else have the same problem?  Thanks
> 
> Hi,
> 
> You are probably failing to run the statd daemon or you may have set
> up over-restrictive /etc/hosts.(allow|deny).

Or /var/lib/nfs/statd does not exist on your system, or it is not
writable by the uid rpc.statd runs under (rpcuser on Red Hat boxes
with all the upgrades).

I've had this problem myself, I don't think it's covered in the FAQ.

I haven't checked if the rpcuser thing is a redhat-ism, probably is,
their script is not doing anything special with rpc.statd so they
must have hacked it into the executable.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
