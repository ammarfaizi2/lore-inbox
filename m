Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUAIPhM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUAIPhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:37:12 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:10883
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S262038AbUAIPhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:37:10 -0500
Date: Fri, 9 Jan 2004 10:49:55 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange lockup with 2.6.0
Message-ID: <20040109104955.B6840@animx.eu.org>
References: <20040109093913.A6710@animx.eu.org> <Pine.LNX.4.44.0401091607050.7051-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.4.44.0401091607050.7051-100000@poirot.grange>; from Guennadi Liakhovetski on Fri, Jan 09, 2004 at 04:18:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:
> On Fri, 9 Jan 2004, Wakko Warner wrote:
> 
> > I usually do a backup of each filesystem simply using tar.  I attempted to
> > backup a machine I had that's running 2.6.0 and it hard locked.
> 
> Are sysrq-keys enabled? If so, could you catch the tar backtrace during
> the lock-up (ALT-SysRq-t)? What was the latest kernel-version that worked?

Yes, but the machine hard locks.  sysrq does not work.  I have a small
utility I wrote that will set the state of the parport (I used this to tell
if it locks up) using outb to the port (This does not effect it in anyway,
it will lockup w/o it running)

This is also the first time I backed up this machine.  2.6.0 is the first
kernel I installed on it.  I can test 2.4.23 later.

> Can you just try to write some data over NFS? Would it lock if you write 1

I am constantly accessing NFS with this machine.  Read and write.  It was
only when I backed it up with tar.  In the event it doesn't lock, tar
crashes w/o error/warning (over NFS).

> byte or 1K or 1M? Does it lock immediately as you start the backup or

It locks up usually at one point, but not always.

> after some time (you could start some process in the background
> periodically printing some info on the terminal, like vmstat, cat
> /proc/interrupts, free, tcpdump on both ends to a file...) Can you try NFS

I can do this I think.  It's fun when running with init being bash.  It will
take some time to do since I can't scroll backwards.

> over TCP? Are other machines, where backup works, also running 2.6,

I can try TCP, but I'm not sure about the server accepting TCP (was there a
compile time option for NFSD to use TCP?)  These 2 machines are the only
ones I have on 2.6.

> 10/100mbps?

100 FD always.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
