Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCZV31>; Mon, 26 Mar 2001 16:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRCZV3S>; Mon, 26 Mar 2001 16:29:18 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:12605 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129245AbRCZV3A>; Mon, 26 Mar 2001 16:29:00 -0500
Date: Mon, 26 Mar 2001 15:27:44 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103262127.PAA24549@tomcat.admin.navo.hpc.mil>
To: dalecki@evision-ventures.com, "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki <dalecki@evision-ventures.com>:
> "Eric W. Biederman" wrote:
> > 
> > Matthew Wilcox <matthew@wil.cx> writes:
> > 
> > > On Mon, Mar 26, 2001 at 10:47:13AM -0700, Andreas Dilger wrote:
> > > > What do you mean by problems 5 years down the road?  The real issue is that
> > > > this 32-bit block count limit affects composite devices like MD RAID and
> > > > LVM today, not just individual disks.  There have been several postings
> > > > I have seen with people having a problem _today_ with a 2TB limit on
> > > > devices.
> > >
> > > people who can afford 2TB of disc can afford to buy a 64-bit processor.
> > 
> > Currently that doesn't solve the problem as block_nr is held in an int.
> > And as gcc compiles an int to a 32bit number on a 64bit processor, the
> > problem still isn't solved.
> > 
> > That at least we need to address.
> 
> And then you must face the fact that there may be the need for
> some of the shelf software, which isn't well supported on 
> correspondig 64 bit architectures... as well. So the
> arguemnt doesn't hold up to the reality in any way.

You are missing the point - I may need to use a 32 bit system to monitor
a large file system. I don't need the compute power of most 64 bit systems
to monitor user file activity.

> BTW. For many reasons 32 bit architecutres are in
> respoect of some application shemes *faster* the 64.

Which is why I want to use them with a 64 bit file system. Some of the
weather models run here have been known to exceed 100 GB data file. Yes
one  file. Most only need 20GB, but there are a couple of hundred of them...  

> Ultra III in 64 mode just crawls in comparision to 32.

Depends on what you are doing. If you need to handle large arrays of
floating point it is reasonable (not great, just reasonable).

> Alpha - unfortulatly an orphaned and dyring archtecutre... which
> is not well supported by sw verndors...

These are NOT the only 64 bit systems - Intel, PPC, IBM (in various guises).
If you need raw compute power, the Alpha is pretty good (we have over a
1000 in a Cray T3..).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
