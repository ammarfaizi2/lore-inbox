Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUCRVFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUCRVFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:05:44 -0500
Received: from server17.pronicsolutions.com ([64.94.232.3]:39591 "EHLO
	server17.pronicsolutions.com") by vger.kernel.org with ESMTP
	id S262961AbUCRVDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:03:02 -0500
From: "Bert Kammerer" <mot@pronicsolutions.com>
To: "'Peter S. Mazinger'" <ps.m@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: BUG in 2.4.25-rc1: attempt to access beyond end of device
Date: Thu, 18 Mar 2004 16:03:10 -0500
Message-ID: <000001c40d2c$6baa6df0$0600a8c0@p17>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0403181711480.10225-100000@lnx.bridge.intra>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server17.pronicsolutions.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pronicsolutions.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have definitely experienced this exact same issue as well ever since
going into 2.4.25. I've tried the patches for 2.4.26 up to and including
2.4.26-pre4 as well and they don't make a difference.

It is interesting to note that this happens with every single machine
running RedHat 7.3 with its default (official) mount version 2.11n.
Apparently as you stated, upgrading mount to a newer version gets rid of
the "error messages". Reverting back to 2.4.24 also clears the problem.

I have been able to confirm that this is happening consistently
regardless of the hardware being used.

Bert

-----Original Message-----
From: Peter S. Mazinger [mailto:ps.m@gmx.net] 
Sent: Thursday, March 18, 2004 11:17 AM
To: Marcelo Tosatti
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG in 2.4.25-rc1: attempt to access beyond end of device


On Mon, 1 Mar 2004, Peter S. Mazinger wrote:

I have seen 2 LKML messages related to it (IBM Serveraid and RedHat 7.3 
related)
Well I have RedHat 7.3, and when I saw the second message I have updated

mount from 2.11n (it's the official/updated RedHat 7.3 version) to 2.12.

The "error" messages are gone. but I do not really know if the error is 
gone.

Peter

> On Fri, 27 Feb 2004, Marcelo Tosatti wrote:
> 
> > 
> > Peter,
> > 
> > Can you try to revert (apply with -R) and see if it happens again, 
> > please?
> 
> Yes, it happens again (the problem appeared at 2.4.25-pre4 time, but 
> that
> patch is to huge for me to find the problematic part)
> 
> Peter
> 
> > 
> > 
> > On Fri, 6 Feb 2004, Peter S. Mazinger wrote:
> > 
> > > Hello!
> > >
> > > my hardware:
> > > x86
> > > ide controller (builtin driver)
> > > ext3 partitions (as modules loaded from initrd)
> > >
> > > if I shutdown -h now the computer, I get as last messages: attempt

> > > to access beyond end of device 03:03 rw=0, want=1044228, 
> > > limit=1044225 (3 times, 03:03/want/limit with other numbers), for 
> > > all mounted (remounted ro) partitions
> > >
> > > distro: RedHat 7.3 (with all updates up to december) kernel is 
> > > pristine: only 2.4.25-rc1 applied (EXPERIMENTAL code disabled)
> > > util-linux: 2.11n-12.7.3 (used umount, if it matters)
> > >
> > > Peter
> > >
> > > --
> > > Peter S. Mazinger <ps dot m at gmx dot net>           ID:
0xA5F059F2
> > > Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 
> > > 59F2
> > >
> > >
> > > __________________________________________________________________
> > > __
> > > Miert fizetsz az internetert? Korlatlan, ingyenes internet
hozzaferes a FreeStarttol.
> > > Probald ki most! http://www.freestart.hu
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> 
> 

-- 
Peter S. Mazinger <ps dot m at gmx dot net>           ID: 0xA5F059F2
Key fingerprint = 92A4 31E1 56BC 3D5A 2D08  BB6E C389 975E A5F0 59F2


____________________________________________________________________
Miert fizetsz az internetert? Korlatlan, ingyenes internet hozzaferes a
FreeStarttol. Probald ki most! http://www.freestart.hu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


