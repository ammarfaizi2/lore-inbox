Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRCWBqo>; Thu, 22 Mar 2001 20:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRCWBq1>; Thu, 22 Mar 2001 20:46:27 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:21749 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S129321AbRCWBoY>; Thu, 22 Mar 2001 20:44:24 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org
Subject: Re: PROBLEM: 2.2.18 oops leaves umount hung in disk sleep
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com> <shs1yrpabky.fsf@charged.uio.no> <54hf0l8ug1.fsf@intech19.enhanced.com> <shspuf98nhy.fsf@charged.uio.no>
From: Camm Maguire <camm@enhanced.com>
Date: 22 Mar 2001 20:43:33 -0500
In-Reply-To: Trond Myklebust's message of "22 Mar 2001 23:09:13 +0100"
Message-ID: <541yrpgsze.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!  Here are the contiguous lines from kern.log:

Mar 21 01:14:47 intech9 kernel: eth0: bogus packet: status=0x80 nxpg=0x57 size=1270
Mar 21 01:14:49 intech9 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Mar 21 01:14:49 intech9 kernel: current->tss.cr3 = 02872000, %%cr3 = 02872000
Mar 21 01:14:49 intech9 kernel: *pde = 00000000
Mar 21 01:14:49 intech9 kernel: Oops: 0000
Mar 21 01:14:49 intech9 kernel: CPU:    0
Mar 22 12:30:08 intech9 kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.

Why would this have not been included, would you happen to know?  In
any case, I understand that its pretty much impossible to debug now,
right?  dmesg wrapped around by the time I got to it (I seem to be
having a lot of ethernet bogus packet messages, as shown above.  I've
chalked this up to the heavy traffic during the amanda backup, but
maybe something is wrong here too/instead?)

Thanks again!

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> >>>>> " " == Camm Maguire <camm@enhanced.com> writes:
> 
>      > I'd be happy to generate one if I could.  I've got the system
>      > map.  The defaults reported by ksymoops are all correct.  Don't
>      > know why it didn't give me more info.  Normally, the info is
>      > reported by klogd anyway, but not here.  I've sent you all I
>      > currently have.  If you can suggest how I can get more, would
>      > be glad to do so.
> 
> 
> Unless you happen to have a dump from 'dmesg', there's probably not
> much you can do to recover the rest of the Oops...
> 
> We need at least the line 'EIP:' if we're to find out where the fault
> occurred. Are you certain that it can't be found in the syslog?
> 
>      > I thought I was running v3.  Can't seem to find anything now
>      > which indicates the protocol version in use, but was under the
>      > impression that v4 was only an option in 2.4.x, no?
> 
> 
> Mar 21 01:14:49 intech9 automount[305]: using kernel protocol version 3 on reawaken
> 
> Sorry, the above message fooled me.
> 
> 
> Cheers,
>   Trond
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
