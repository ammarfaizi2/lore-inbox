Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTK3Aed (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTK3Aed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 19:34:33 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:5895 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264490AbTK3Aeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 19:34:31 -0500
Date: Sun, 30 Nov 2003 01:34:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Clausen <clausen@gnu.org>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031130003428.GA5465@win.tue.nl>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl> <20031129222722.GA505@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129222722.GA505@gnu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 09:27:22AM +1100, Andrew Clausen wrote:

> > > Some users, having problems, did mention the usage of 2.6 kernel. If the
> > > geometry changed during the fdisk, etc process then it could result also
> > > booting problem?
> > 
> > Let me continue to stress: geometry does not exist.
> > Consequently, it cannot change.
> 
> Let me continue to stress: geometry DOES exist.

Ha, Andrew - you know these things, I know these things - please
do not confuse matters.

My first letter had as essential content: the Linux 2.6 kernel
does not make geometry information available to user space.
Thus, if user space asks the kernel and prints an error message
in case the answer is unexpected, then such user space is broken
under 2.6. There is nothing to gain from asking the kernel.

That was a letter for you - parted should be fixed, otherwise
there will be a long sequence of users that worry that things
might be wrong.


My second letter was for Szaka and affirmed that fdisk cannot
change this non-existent geometry. You still believe in fairies,
I mean, in disk geometry, that is OK, I don't mind, but still,
whatever it is you believe in, fdisk cannot change it.


> It is an abstract construct that is stored in your BIOS that some
> configurations use and need for booting.

I am happy with that description.
"Disk geometry is: some numbers that your BIOS invents".

Of course, details are always more complicated.
What the BIOS invents may be dependent on user settings in its setup.
There are also numbers that certain operating systems or boot managers
invent. Equal to or different from what your BIOS has thought of.



> (i.e. have you got any evidence that, say, that 99.x% of Windows XP
> installations use LBA to bootstrap?)

Just ask yourself this question: does Windows XP require a bootable
partition to start below the 1024 cylinder mark?
Windows NT4 has such a restriction. Not Windows 2000 or XP.



> > Usually booting goes like this: the BIOS reads sector 0 (the MBR)
> > from the first disk, and starts the code found there. What happens
> > afterwards is up to that code. If that code uses CHS units to find
> > a partition, and if the program that wrote the table has different
> > ideas about those units than the BIOS, booting may fail.
> 
> Exactly.

Good. We agree.

Andries

