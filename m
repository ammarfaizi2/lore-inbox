Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317393AbSHHI6i>; Thu, 8 Aug 2002 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSHHI6i>; Thu, 8 Aug 2002 04:58:38 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:36617 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317393AbSHHI6i>; Thu, 8 Aug 2002 04:58:38 -0400
Message-ID: <3D5233BC.96ABDF73@aitel.hist.no>
Date: Thu, 08 Aug 2002 11:02:52 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.30 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
References: <Pine.LNX.4.44.0207311500210.1038-100000@dlang.diginsite.com> <3D49006C.12ABC6FC@aitel.hist.no> <20020803034019.A140@toy.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> > Lots of other bootup initialization, like DHCP,
> > might move to userspace as well.  This gives a smaller
> > and safer kernel.
> 
> Why *safer*? Partition (,DHCP,..) code is ran once at boot. It is hard for
> it to harm security.

I wouldn't worry about partition detection, but network stuff
is always risky.  A "bad guy" could listen for DHCP
and try to fake a response or do a buffer overflow.

Userspace programs are supposedly easier to fix, and a
messed-up userspace isn't quite as bad as a messed up kernel
when an attacker tries to get in.  

I think kernel simplicity is the main driving factor here though.
Things that _can_ be done in userspace without major trouble
should be done in userspace.  And of course there's embedded
users who actually want to save the space currently used
by partition detection etc.  No need for that when
all your fs'es are on eprom.  No need in a diskless
workstation either.

Helge Hafting
