Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbRE2UKN>; Tue, 29 May 2001 16:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbRE2UKE>; Tue, 29 May 2001 16:10:04 -0400
Received: from cx595243-c.okc1.ok.home.com ([24.6.27.53]:29058 "EHLO
	quark.localdomain") by vger.kernel.org with ESMTP
	id <S261700AbRE2UJ5>; Tue, 29 May 2001 16:09:57 -0400
From: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Date: Tue, 29 May 2001 15:09:54 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: elko <elko@home.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <E154fWT-0004BO-00@the-village.bc.nu> <01052917371700.32333@ElkOS>
In-Reply-To: <01052917371700.32333@ElkOS>
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
Cc: Jacky Liu <jq419@my-deja.com>
MIME-Version: 1.0
Message-Id: <01052915095400.32108@quark>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 May 2001 10:37, elko wrote:
> On Tuesday 29 May 2001 11:10, Alan Cox wrote:
> > > It's not a bug.  It's a feature.  It only breaks systems that are run
> > > w= ith "too
> > > little" swap, and the only difference from 2.2 till now is, that the
> > > de= finition
> > > of "too little" changed.
> >
> > its a giant bug. Or do you want to add 128Gb of unused swap to a full
> > kitted out Xeon box - or 512Gb to a big athlon ???
>
> this bug is biting me too and I do NOT like it !
>
> if it's a *giant* bug, then why is LK-2.4 called a *stable* kernel ??

This has been my complaint ever since the 2.2.0 kernel.  I did not see
a reasonably stable release until 2.2.12.  I do not understand why
code with such serious reproducible problems is being introduced into
the even numbered kernels.  What happened to the plan to use only the
odd numbered kernels for debugging and refinement of the code?  I
never said anything because I thought the the kernel developers would
eventually get back on track after the mistakes of the 2.2.x kernels
but it has been years now and it still has not happened.  I do not
wish sound un-appreciative to those that have put so much wonderful
work into the Linux kernel but this is the same thing we criticize
Microsoft for.  Putting out production code that obviously is not
ready.  Please lets not earn the same reputation of such commercial
companies.  

By the way,  The 2.4.5-ac3 kernel still fills swap and runs out of
memory during my morning NFS incremental backup.  I got this message
in the syslog.

May 29 06:39:15 (none) kernel: Out of Memory: Killed process 23502 
(xteevee).

For some reason xteevee is commonly the process that gets killed.  My
understanding is that it is part of Xscreensaver, but it was during my
backup.

This was the output of 'free' after I got up and found the swap
completely full.  By that time the memory was in a reasonable state
but the swap space is still never being released.

             total       used       free     shared    buffers     cached
Mem:        255960     220668      35292        292     110960      80124
-/+ buffers/cache:      29584     226376
Swap:        40124      40112         12


Configuration
-------------
AMD K6-2/450
256Mb RAM
2.4.5-ac3 Kernel compiled with egcs-1.1.2.

