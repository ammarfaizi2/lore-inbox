Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314067AbSDZOvm>; Fri, 26 Apr 2002 10:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSDZOvl>; Fri, 26 Apr 2002 10:51:41 -0400
Received: from heffalump.fnal.gov ([131.225.9.20]:63166 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S314067AbSDZOvl>;
	Fri, 26 Apr 2002 10:51:41 -0400
Date: Fri, 26 Apr 2002 09:51:40 -0500
From: Dan Yocum <yocum@fnal.gov>
Subject: Re: Poor NFS client performance on 2.4.18?
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3CC9697C.41473ED9@fnal.gov>
MIME-version: 1.0
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13SGI_XFS_1.0.2 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3CC86BDC.C8784EA2@fnal.gov> <shsu1pyppnz.fsf@charged.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond,

So, would I be correct in assuming that backing out the
linux-2.4.18-ping.dif patch would solve the problem in the short term?

Thanks,
Dan

Trond Myklebust wrote:
> 
> >>>>> " " == Dan Yocum <yocum@fnal.gov> writes:
> 
>      > Trond, et al.  I'm getting poor NFS performance (~250KBps read
>      > and write) on 2.4.18 and am wondering if I'm the only one.
>      > There is no performance drop under other OSs or other kernel
>      > versions, so I don't think it's the server.
> 
>      > Here's the the details:
> 
>      > 2.4.18 patched with:
>      >  NFS client patches (linux-2.4.18-NFS_ALL.dif)
>      >  xfs-1.1-PR1-2.4.18-all.patch Ingo's Foster IRQ patch (these
>      >  are dual Xeons)
> 
>      > If you need any more details, let me know.
> 
> The latest NFS_ALL patches include experimental code that changes the
> UDP congestion control. I'm basically trying to relax the algorithm to
> what is standard on *BSD (i.e. we follow the standard Van Jacobson).
> 
> This would mean that we don't wait for the reply from the server
> before we send off the next request. Unfortunately, there appears to
> be a lot of setups out there that start to drop packets when this
> occurs, and I haven't yet finished determining the root cause.
> 
> If I can manage to get my laptop to work again, I'll try to
> investigate a bit more this weekend...
> 
> Cheers,
>   Trond



-- 
Dan Yocum
Sloan Digital Sky Survey, Fermilab  630.840.6509
yocum@fnal.gov, http://www.sdss.org
SDSS.  Mapping the Universe.
