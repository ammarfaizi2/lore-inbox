Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286360AbRL0RD1>; Thu, 27 Dec 2001 12:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286356AbRL0RDQ>; Thu, 27 Dec 2001 12:03:16 -0500
Received: from dialin-145-254-146-056.arcor-ip.net ([145.254.146.56]:57873
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S286361AbRL0RDJ>; Thu, 27 Dec 2001 12:03:09 -0500
Message-ID: <3C2B5165.B6A6CEC1@loewe-komp.de>
Date: Thu, 27 Dec 2001 17:50:45 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.14-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Dave Carrigan <dave@rudedog.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel crash with knfsd
In-Reply-To: <87heqdanpx.fsf@pdaverticals.com> <15402.12470.768116.337927@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown schrieb:
> 
> On  December 26, dave@rudedog.org wrote:
> > (I am not subscribed, so please CC any response to me)
> >
> > I am having the following problem:
> >
> > Sometimes, when my wife's laptop comes out of suspend mode, it causes my
> > nfs server to lock up hard -- I have to hit the reset button. Even after
> > I reset the server, it will just lock up again a few seconds after knfsd
> > starts, as long as the laptop is still on the net. If I suspend the
> > laptop, then start the server, it will start fine, and I can usually
> > unsuspend the laptop after that without problems. Up until yesterday,
> > there was never anything in the logs.
> 
> snip
> 
> >  Dec 25 14:51:35 pern kernel: Call Trace: [nfsd_findparent+52/256] [find_fh_dentry+558/820] [fh_verify+508/988] [reschedule_idle+98/540] [nfsd_lookup+114/1016]
> >  Dec 25 14:51:35 pern kernel:    [nfsd3_proc_lookup+212/224] [nfsd_dispatch+211/416] [svc_process+653/1240] [nfsd+503/808] [kernel_thread+40/56]
> >  Dec 25 14:51:35 pern kernel:
> >  Dec 25 14:51:35 pern kernel: Code:  Bad EIP value.
> 
> snip
> 
> >
> > The server is running 2.4.16 with XFS patches. The nfs-exported
> > directories are both xfs and rieserfs. The laptop runs kernel autofs,
> 
> I have had several reports of XFS triggering an oops early in
> nfsd_findparent.  I thought that the problem has been fixed by
> 2.4.16....
> 
> Can you send me a copy of nfsd_findparent out of fs/nfsd/nfsfh.c
> in the source tree that you are using?
> 

There was a fix in 2.4.3 for lookup("..") failing.

This oops seems to me the one I am waiting to happen again for 4 weeks now :-(

The i_node->op->something is NULL, I guess.
