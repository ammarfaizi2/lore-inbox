Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310333AbSCGNy6>; Thu, 7 Mar 2002 08:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310332AbSCGNyl>; Thu, 7 Mar 2002 08:54:41 -0500
Received: from employees.nextframe.net ([212.169.100.200]:47086 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S310329AbSCGNyc>; Thu, 7 Mar 2002 08:54:32 -0500
Date: Thu, 7 Mar 2002 14:54:34 +0100
From: Morten Helgesen <admin@nextframe.net>
To: "Steven A. DuChene" <linux-clusters@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_YIELD undeclared with Trond's NFS patch w/2.4.19-pre2-ac2
Message-ID: <20020307145434.O142@sexything>
Reply-To: admin@nextframe.net
In-Reply-To: <20020307084514.C16224@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307084514.C16224@lapsony.mydomain.here>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless my memory is corrupt, you can just replace the 'let`s set the SCHED_YIELD bit' with 'yield()' ...

== Morten

On Thu, Mar 07, 2002 at 08:45:14AM -0500, Steven A. DuChene wrote:
> I am attempting to apply Trond's linux-2.4.18-NFS_ALL.dif patch to 2.4.19-pre2-ac2
> I get the patch to apply once I massage fs/nfs/inode.c a little bit but when I try
> to compile it I get:
> 
> svcsock.c: In function `svc_recv':
> svcsock.c:987: `SCHED_YIELD' undeclared (first use in this function)
> svcsock.c:987: (Each undeclared identifier is reported only once
> svcsock.c:987: for each function it appears in.)
> make[3]: *** [svcsock.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.4.X/net/sunrpc'
> make[2]: *** [first_rule] Error 2
> 
> Now I know there were some changes because of the O(1) stuff in the ac2 patch but
> what is the process for eliminating references to SCHED_YIELD?
> -- 
> Steven A. DuChene      linux-clusters@mindspring.com
>                       sduchene@mindspring.com
> 
>         http://www.mindspring.com/~sduchene/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
