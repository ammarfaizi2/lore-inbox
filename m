Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSHMDCy>; Mon, 12 Aug 2002 23:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSHMDCy>; Mon, 12 Aug 2002 23:02:54 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:20485 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318917AbSHMDCx>; Mon, 12 Aug 2002 23:02:53 -0400
Date: Mon, 12 Aug 2002 23:00:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] The List, pass #2
In-Reply-To: <3D5233BC.96ABDF73@aitel.hist.no>
Message-ID: <Pine.LNX.3.96.1020812225814.7583C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Helge Hafting wrote:

> Pavel Machek wrote:
> 
> > > Lots of other bootup initialization, like DHCP,
> > > might move to userspace as well.  This gives a smaller
> > > and safer kernel.
> > 
> > Why *safer*? Partition (,DHCP,..) code is ran once at boot. It is hard for
> > it to harm security.
> 
> I wouldn't worry about partition detection, but network stuff
> is always risky.  A "bad guy" could listen for DHCP
> and try to fake a response or do a buffer overflow.

I don't really care about DHCP, but anything needed for booting is sure
better off in the kernel. It can be a compile option for the embedded
folks, but I suspect the code to call the user program is about as large
as the code to actually check the partitions.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

