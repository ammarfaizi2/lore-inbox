Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266965AbTCDXxe>; Tue, 4 Mar 2003 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbTCDXxe>; Tue, 4 Mar 2003 18:53:34 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:5248 "EHLO bjl1.jlokier.co.uk")
	by vger.kernel.org with ESMTP id <S266965AbTCDXxd>;
	Tue, 4 Mar 2003 18:53:33 -0500
Date: Wed, 5 Mar 2003 00:03:34 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Joseph Wenninger <jowenn@jowenn.at>, Miles Bader <miles@gnu.org>,
       DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030305000334.GA2617@bjl1.jlokier.co.uk>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <1046329422.1404.10.camel@jowennmobile> <3E5DCC16.FD6BAD62@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E5DCC16.FD6BAD62@daimi.au.dk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> > For KDE 3.1 I've written a mount watcher, which checks the modification
> > time of the /etc/mtab to recognize mount/unmount activity, which broke
> > for linux from scratch( for now, they have updated there install
> > instructions), because they linked to /proc/mounts, which doesn't seem
> > to support mtime.
> 
> It seems the mtime of anything under /proc simply gives the current time.
> Would that be hard to change? And would anything break if /proc/mounts
> gave the time of the last change? It shouldn't be a major problem to
> record the time of the last sucessfull mount, remount, or unmount.

It would be much better if it were possible to use
fcntl(?,F_NOTIFY,...) to monitor the contents of /proc/mounts.  (It
would have to be in a subdirectory of its own for this).

-- Jamie
