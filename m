Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284853AbRLZUS0>; Wed, 26 Dec 2001 15:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRLZUSQ>; Wed, 26 Dec 2001 15:18:16 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:55696 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S284899AbRLZUSF>; Wed, 26 Dec 2001 15:18:05 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Dave Carrigan <dave@rudedog.org>
Date: Thu, 27 Dec 2001 07:19:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15402.12470.768116.337927@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel crash with knfsd
In-Reply-To: message from Dave Carrigan on  December 26
In-Reply-To: <87heqdanpx.fsf@pdaverticals.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  December 26, dave@rudedog.org wrote:
> (I am not subscribed, so please CC any response to me)
> 
> I am having the following problem:
> 
> Sometimes, when my wife's laptop comes out of suspend mode, it causes my
> nfs server to lock up hard -- I have to hit the reset button. Even after
> I reset the server, it will just lock up again a few seconds after knfsd
> starts, as long as the laptop is still on the net. If I suspend the
> laptop, then start the server, it will start fine, and I can usually
> unsuspend the laptop after that without problems. Up until yesterday,
> there was never anything in the logs.

snip

>  Dec 25 14:51:35 pern kernel: Call Trace: [nfsd_findparent+52/256] [find_fh_dentry+558/820] [fh_verify+508/988] [reschedule_idle+98/540] [nfsd_lookup+114/1016] 
>  Dec 25 14:51:35 pern kernel:    [nfsd3_proc_lookup+212/224] [nfsd_dispatch+211/416] [svc_process+653/1240] [nfsd+503/808] [kernel_thread+40/56] 
>  Dec 25 14:51:35 pern kernel: 
>  Dec 25 14:51:35 pern kernel: Code:  Bad EIP value.

snip

> 
> The server is running 2.4.16 with XFS patches. The nfs-exported
> directories are both xfs and rieserfs. The laptop runs kernel autofs,

I have had several reports of XFS triggering an oops early in
nfsd_findparent.  I thought that the problem has been fixed by
2.4.16....

Can you send me a copy of nfsd_findparent out of fs/nfsd/nfsfh.c
in the source tree that you are using?

NeilBrown
