Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313671AbSDHPTJ>; Mon, 8 Apr 2002 11:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313672AbSDHPTI>; Mon, 8 Apr 2002 11:19:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42501 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313671AbSDHPTG>; Mon, 8 Apr 2002 11:19:06 -0400
Date: Mon, 8 Apr 2002 11:16:28 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.3.96.1020408110054.21476E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Apr 2002, Richard Gooch wrote:


> But I *want* to write while the drive is spun down. And leave it spun
> down until the system is RAM starved (or some threshold is reached).

  The threshold I hit is how much think time I want to risk. I have no
problem spinning down the drive after inactivity, but the idea of
investing several hours making little changes in a program or proposal
document and then maybe losing them... batteries are just not that
expensive.

  Looking at the blinking of my disk light, it *appears* that by tuning
bdflush you can get a user selected time between sweeps, and use hdparm to
spin down (I assume your laptop doesn't use SCSI!) after a minute or so.
Tuning bdflush somewhat relies on using either -aa or mainline VM, perhaps
version as well. You should be able to only flush every N minutes with any
of them, but the meaning of /sys/vm/bdflush seems somewhat dependent of
code behind it. Still, you should be able to get the behaviour you want
without making it manditory for everyone.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

