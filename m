Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSENT3k>; Tue, 14 May 2002 15:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316006AbSENT3j>; Tue, 14 May 2002 15:29:39 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:19827 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S314123AbSENT3i>; Tue, 14 May 2002 15:29:38 -0400
Date: Tue, 14 May 2002 14:29:33 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205141929.OAA81537@tomcat.admin.navo.hpc.mil>
To: viro@math.psu.edu, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
cc: mark@mark.mielke.cc, elladan@eskimo.com,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> 
> On Tue, 14 May 2002, Jesse Pollard wrote:
>  
> > However, not all daemons run as root, but do log into /var/adm or /var/log.
> > If these fill up the log device without restraint, then your audit logs will
> > ALSO be affected (unless you have syslog send them to a different host).
> 
> syslogd _does_ run as root and it can happily overflow the damn thing,
> reserved blocks or not.
> 

Absolutely - and it should, since that IS the primary audit log daemon.

I don't consider that a "bug". Only if a "user" process (non-root, or
non-designated user) can exceed the set bounds, by either appending, or
filling in a hole, should there be a bug in the system.

Personally, I think ext2 works great. (And I DON'T count the time experimental
code with the warning "caution, may be hazardous to your filesystem" as
causing problems - I had expected it to.)

I've never had a problem with ext2, even when I did fill the filesystem.
I was able to log in and view the audit log, and clean up without
problems - exactly as I would expect.

It has been the most stable file system I've ever used (and I've used
quite a few - old Files-11 and Files-32, RT11, dos, UFS, UNICOS nc1, SGI
efs and xfs ...)

Easier fsck procedure than all of them. Fixed any inconsistancies as well
and didn't loose any resident files.

I've only lost one ext2fs - and that was due to a head crash. The drive
had been running for a couple of years continuously, with only a few
mis-guided reboots.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
