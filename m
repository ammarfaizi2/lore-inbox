Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUDPBSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUDPBSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:18:05 -0400
Received: from wilma.widomaker.com ([204.17.220.5]:12292 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S262073AbUDPBR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:17:58 -0400
Date: Thu, 15 Apr 2004 21:14:02 -0400
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NFS and kernel 2.6.x
Message-ID: <20040416011401.GD18329@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I'm having a hard time right now with NFS on kernel 2.6.

I tried to search archives but can't find much on my exact problem.  If
I missed something good, a pointer would be great.

Anyway, the problem: NFS writes are broken in 2.6 on my machine.

I normally mount several volumes from a Sun SS5 running NetBSD.

It's worked great for years, and usually is not too bad on speed.

When I moved to Linux kernel 2.6.1, writes to the NetBSD server got
incredibly slow.  Like it went from around 600K/sec to just a few K/sec
to maybe 25K/sec.

By contrast, rsync runs at around 900K/sec or faster, close to wire
speed (yes, raw speed, not compressed speed).

With kernels 2.6.3 and 2.6.5, it doesn't work at all.  If I do something
like this:

% cp bigfile /public

It just hangs.  After that umounts or even reads of that volume hang.
They can be killed, but not always.  Gnome's Nautilus for example gets
permanently hung, though that might be its own issue.

Offhand, I cannot remember what NFS write performance was with Linux
kernel 2.4, but it was several hundred K/sec unless the server was
loaded.

Reading from the NFS server seems to still be fine.  For example, just
now I copied a file from there at around 660K/sec using kernel 2.6.5
on the client.

Anyway, I would like to explore this further and solve the problem.

Details on my setup:

NFS server:

    Sun SS5
    10baseT ethernet (100baseT card available, not used)
    NetBSD 1.6.1
    pretty much a plain vanilla server setup

Network:

    simple LAN with three machines, connected via a full duplex
    multi-speed switch

NFS client:

    vanilla PC
    Intel Pro/100 ethernet
    Slackware 9.1
    Linux kernel 2.6.5, plain with no mods or patches, only enough
	drivers and features enabled to run my workstation
	configuration as close as I could get to my Linux 2.4
	kernel

-- 
shannon "AT" widomaker.com -- ["All of us get lost in the darkness,
dreamers turn to look at the stars" -- Rush ]
