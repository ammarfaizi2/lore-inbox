Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbTEHNII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 09:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbTEHNIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 09:08:07 -0400
Received: from [65.244.37.61] ([65.244.37.61]:2654 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S261544AbTEHNIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 09:08:04 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A92020CD107@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: Simon Kelley <simon@thekelleys.org.uk>,
       Filip Van Raemdonck <mechanix@debian.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: RE: Binary firmware in the kernel - licensing issues.
Date: Thu, 8 May 2003 09:20:11 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Simon Kelley [mailto:simon@thekelleys.org.uk]

[snip]

My comments apply _only_ to firmware binaries for which the vendor
has given explicit license for free redistribution with GPL code.

> Briefly, the arguments that binary firmware which is copied into the
> hardware by the kernel is OK are these.
>
> 1) The GPL is unclear on this point.
> 2) The firmware is not linked with the kernel code and not executed
>     by the same processor as the kernel.

These are two separate issues, and both are crucial.  Four ways to 
handle firmware have been discussed.  1.) firmware as data in the
module image, 2.) firmware as data in userspace image, 3.) firmware
as file loaded by module, 4.) firmware as file loaded by userspace.

The first option might be debatable (non-GPL stuff linked into GPL
module), but I think it parallels 'magic' values written to registers.
Likewise the second option might not fly, though this removes it from
the kernel, it still leaves open the question of distro's that won't
go along.

The third option (and even more so the fourth) seem to have no point at
which the GPL could apply.  The firmware is now _clearly_ not linked in
any fashion with any GPL code.  It's just data that the kernel or other
moves from A to B at the behest of the user.  This again leaves only
the question of distro's that won't go this way.

For such distro makers: if firmware continues to become more prevalent
in devices, and the vendors are ok with redistribution, then those
distro makers lose to some extent, in the long run.  To say that distro
X won't do it, so we can't is backwards.

The second half of the original point is crucial - firmware does not run
on the same CPU's as the kernel.

> 3) Not allowing binary firmware leads to technical decisions which would
>     not be made in the absence of prohibition.
> 4) The same hardware and firmware is unambiguously OK if the firmware
>     is held in flash rather than initialised by the host.
> 5) There are current examples in the kernel of drivers with source-free
>     binary firmware blobs going back at least to version 1.3. This means
>     that someone might have considered this before and OKed it. It also
>     means that anyone who added code to the kernel since 1.3 had
>     evidence that for Linux the interpration of this GPL grey area
>     was to allow binary firmware. It is difficult to a contributor to
>     turn around now and claim copyright infrigement by distributing their
>     work with binary firmware when the kernel already had binary firmware
>     in it when their contribution was first made.
> 6) AFAIK nobody has claimed that the existing firmware blobs in Linux
>     violate their copyright on GPL-licensed kernel contributions and
>     fairly certainly nobody has pressed this in law. (Since if they
>     had it would be well-known.)
>
> The arguments against allowing binary firmware are these.
>
> 1) The GPL is unclear on this point.
> 2) The intention of the GPL is to allow redistribution only
>     with source.

The intention of the GPL is to allow redistribution _of GPL code, or
code linked to GPL code_ with source.

Makes a big difference.  Hence the distinctions made above.

> 3) Some contributors to the kernel might want their work distributed
>     only with all source, including firmware source. These people
>     would contend that their copyright had been violated and would
>     feel aggrieved or sue for lots of money.

That position would be a little inconsistent - as long as the code they
personally hold the copyright for was not involved.  There are vendors
shipping systems that use Linux, but are shipped with non-GPL
applications.  Is anyone aggrieved?  (Probably, but hardliners aside...)

> Anybody  want to write a better summary?

No, just some maundering nitpicking...

