Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTJQRXK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTJQRXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:23:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15112 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263151AbTJQRXH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:23:07 -0400
Date: Fri, 17 Oct 2003 13:07:46 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Tomt <andre@tomt.net>
cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
In-Reply-To: <1065690658.10389.19.camel@slurv>
Message-ID: <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Andre Tomt wrote:

> On Thu, 2003-10-09 at 10:55, Måns Rullgård wrote:
> > > Was this a 4 port or 2 port HPT controller? Keep in mind, two disks on
> > > the same IDE channel severely degrades performance, *especially* with
> > > RAID.
> > 
> > It's a four port SATA controller.  I'd never even think about placing
> > two disks on the same cable.
> 
> You can't either, considering it is SATA :-)
> 
> However, I wouln't count on superior performance from software based
> RAID 5 (ata/fakeraid or otherwise), that is whats real raid controllers
> are for.

While an overloaded system may benefit from offloaded the CPU
requirements of RAID, unless you go to a very expensive external unit
the kernel RAID will usually outperform the inexpensive RAID embedded on
a controller. The kernel simply knows more about the data needs and can
can do things a controller can't.

You can also use only part of a drive, by partition, in a RAID group,
leaving the rest to be used as dumb disk. Very cost effective, if only a
part of the data justified mirroring, you don't need to mirror whole
drives. Yes, that's a cost vs. speed tradeoff, but an effective one
where reliabiity is needed, but performance is not critical.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

