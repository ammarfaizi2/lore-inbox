Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268367AbTAMWJq>; Mon, 13 Jan 2003 17:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268375AbTAMWJp>; Mon, 13 Jan 2003 17:09:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28688 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S268367AbTAMWJo>; Mon, 13 Jan 2003 17:09:44 -0500
Date: Mon, 13 Jan 2003 17:16:08 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
In-Reply-To: <15902.16227.924630.143293@wombat.chubb.wattle.id.au>
Message-ID: <Pine.LNX.3.96.1030113165748.22949A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003, Peter Chubb wrote:

> >>>>> "Andrew" == Andrew McGregor <andrew@indranet.co.nz> writes:

> Andrew> Change it to be the offset to the data area, which should be
> Andrew> the same for all of them?
> 
> I thought about that, but I'm unsure if there's any way to get from
> that offset to the directory information.  As far as I can tell,
> there's no concept of an inode separate from directory entry on iso9660
> --- the directory entry/entries all contain all the information that
> describes a file.  Which means that the inumber has to point to some
> directory node.

I can see that you would have to carry that information forward to the
"inode" if you used the data area address, for stat that's probaby not an
issue, for open after you open the file you don't really need access
checking and the times on a CD don't change.

What's the case where you are starting with an inode and trying to get to
a filename without having gone through a dir entry to the inode? No one is
running things like dump/restore on iso9660 I hope!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

