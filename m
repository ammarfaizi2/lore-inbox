Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbUKEFAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUKEFAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 00:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUKEFAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 00:00:51 -0500
Received: from smtpout.mac.com ([17.250.248.87]:36316 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262597AbUKEFAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 00:00:44 -0500
In-Reply-To: <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
References: <200411030751.39578.gene.heskett@verizon.net> <87k6t24jsr.fsf@asmodeus.mcnaught.org> <200411031733.30469.rmiller@duskglow.com> <200411040839.34350.vda@port.imtp.ilyichevsk.odessa.ua> <20041105023850.GC17010@eskimo.com> <slrn-0.9.7.4-4729-165-200411051409-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9554BB1E-2EE7-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       DervishD <lkml@dervishd.net>, Russell Miller <rmiller@duskglow.com>,
       Elladan <elladan@eskimo.com>, linux-kernel@vger.kernel.org,
       Jim Nelson <james4765@verizon.net>, M?ns Rullg?rd <mru@inprovide.com>,
       Gene Heskett <gene.heskett@verizon.net>,
       Doug McNaught <doug@mcnaught.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: is killing zombies possible w/o a reboot?
Date: Fri, 5 Nov 2004 00:00:16 -0500
To: Tim Connors <tconnors+linuxkernel1099624161@astro.swin.edu.au>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2004, at 22:10, Tim Connors wrote:
> Elladan <elladan@eskimo.com> said on Thu, 4 Nov 2004 18:38:50 -0800:
>> If a process is in D state and receives a SIGKILL, assume it must exit
>> within a few seconds or it's a bug, and dump as much information about
>> it as is practical...?
>
> Of course, it's not necessarily a bug. Someone could have just kicked
> the ethernet, and so your process is stuck waiting for a read/write.

In any case, if a process is sleeping in-kernel, I expect that either 
it's an
interruptible sleep or a guaranteed-short sleep.  If it's neither, it's 
a bug.  If
I kick out an ethernet and it makes "ping" hang in "D", that's bad.  I 
think
that eventually _all_ kernel sleeps on the behalf of user-space 
processes
will become interruptible.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


