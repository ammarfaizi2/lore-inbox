Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281712AbRKULIL>; Wed, 21 Nov 2001 06:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKULHv>; Wed, 21 Nov 2001 06:07:51 -0500
Received: from [194.65.152.209] ([194.65.152.209]:3249 "EHLO
	criticalsoftware.com") by vger.kernel.org with ESMTP
	id <S281703AbRKULHo>; Wed, 21 Nov 2001 06:07:44 -0500
Message-Id: <200111211108.fALB8K291684@criticalsoftware.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: copy to user
Date: Wed, 21 Nov 2001 11:02:39 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt> <20011120144414.C1308@lynx.no>
In-Reply-To: <20011120144414.C1308@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you put the process in (un)interruptible sleep in the kernel, won't this
> be enough?  This is different than SIGSTOP.  Is the requirement that this
> process not leave the kernel call, or that it is actually consuming CPU
> cycles as well?

The process needs to be using CPU time, however, there must be a chance to 
the scheduler to change the current process... if this occurs, than the delay 
has to be aborted. 

>
> > About using udelay... this soluction seemed fine to me at first but if I
> > hang the CPU with udelay the scheduler will no be doing it's job (isn't
> > it?). This would give me even more intrusiveness (another requirement:
> > the less intrusiveness as possible).
>
> It would probably work OK on an SMP system, since tasks can still be run
> on the other CPU.
>
> Cheers, Andreas

-- 
Luís Henriques
