Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbSJMTVO>; Sun, 13 Oct 2002 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbSJMTVO>; Sun, 13 Oct 2002 15:21:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:3744 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261619AbSJMTVN>;
	Sun, 13 Oct 2002 15:21:13 -0400
Message-ID: <3DA9C901.5409710D@digeo.com>
Date: Sun, 13 Oct 2002 12:26:57 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: Henrik =?iso-8859-1?Q?St=F8rner?= <henrik@hswn.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 breaks Soundblaster OSS driver and smbfs modules
References: <20021013154435.GA25380@hswn.dk> <Pine.LNX.4.44.0210132029310.23052-100000@cola.enlightnet.local>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Oct 2002 19:26:58.0028 (UTC) FILETIME=[7F1E72C0:01C272EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
> 
> On Sun, 13 Oct 2002, Henrik Størner wrote:
> 
> > Yes, I still have an old SB16 ISA card in my machine. Works
> > fine i 2.5.41, but with 2.5.42 I get this:
> >
> > osiris:~ $ sudo /sbin/depmod -ae
> > depmod: *** Unresolved symbols in /lib/modules/2.5.42/kernel/fs/smbfs/smbfs.o
> > depmod:         do_schedule
> 
> My local 2.5.42 tree doesn't have any references to do_schedule at all.
> Any funny patches?
> 

That's from the kgdb patch.  He's using a -mm patchset.  do_schedule()
is exported so it's probably a build thing.  `make clean' perhaps?
