Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281061AbRKTVoq>; Tue, 20 Nov 2001 16:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTVoj>; Tue, 20 Nov 2001 16:44:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:30969 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281016AbRKTVob>;
	Tue, 20 Nov 2001 16:44:31 -0500
Date: Tue, 20 Nov 2001 14:44:14 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy to user
Message-ID: <20011120144414.C1308@lynx.no>
Mail-Followup-To: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.31.0111202040180.23000-100000@mail.deis.isec.pt>; from umiguel@alunos.deis.isec.pt on Tue, Nov 20, 2001 at 08:54:42PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  20:54 +0000, Luis Miguel Correia Henriques wrote:
> The reason that I need it to spend CPU time is that I'm developing a fault
> injector. The purpose of a fault injection tool is, as you could imagine,
> to test some critical systems and it's capacity to recover from fails. The
> reason for changing the code of a process is that process must be delayed
> but without leaving the CPU - everything must look like nothing wrong is
> happening, except for other processes that are waiting for something from
> the delayed process...
>
> I suppose now you can understand why SIGSTOP won't work.

If you put the process in (un)interruptible sleep in the kernel, won't this
be enough?  This is different than SIGSTOP.  Is the requirement that this
process not leave the kernel call, or that it is actually consuming CPU
cycles as well?

> About using udelay... this soluction seemed fine to me at first but if I
> hang the CPU with udelay the scheduler will no be doing it's job (isn't
> it?). This would give me even more intrusiveness (another requirement: the
> less intrusiveness as possible).

It would probably work OK on an SMP system, since tasks can still be run
on the other CPU.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

