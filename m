Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313255AbSDDQnp>; Thu, 4 Apr 2002 11:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313256AbSDDQnd>; Thu, 4 Apr 2002 11:43:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:20156 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313255AbSDDQnX>;
	Thu, 4 Apr 2002 11:43:23 -0500
Date: Thu, 4 Apr 2002 11:43:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.8-pre1 fs/dquot
In-Reply-To: <3CAC3F42.4040100@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0204041142240.22660-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Apr 2002, Martin Dalecki wrote:

> Looking further through the pre patch I have found the following:
> 
> diff -Nru a/fs/dquot.c b/fs/dquot.c
> --- a/fs/dquot.c	Wed Apr  3 17:11:14 2002
> +++ b/fs/dquot.c	Wed Apr  3 17:11:14 2002
> ...
> +static ctl_table fs_table[] = {
> + 
> {FS_NRDQUOT, "dquot-nr", &nr_dquots, 2*sizeof(int),
> + 
>   0444, NULL, &proc_dointvec},
> + 
> {},
> +};
> 
> 
> What the heck is "dquot-nr"?

The name that used to be there in 2.5.7 and before.  Check kernel/sysctl.c -
this stuff had been moved from there verbatim.

