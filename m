Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSKZTes>; Tue, 26 Nov 2002 14:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266660AbSKZTeJ>; Tue, 26 Nov 2002 14:34:09 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:58877 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S266638AbSKZTdT>; Tue, 26 Nov 2002 14:33:19 -0500
Date: Tue, 26 Nov 2002 12:37:32 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Dike <jdike@karaya.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1
Message-ID: <20021126123732.H9054@schatzie.adilger.int>
Mail-Followup-To: Jeff Dike <jdike@karaya.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <p73u1i4ub3g.fsf@oldwotan.suse.de> <200211261829.NAA02265@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211261829.NAA02265@ccure.karaya.com>; from jdike@karaya.com on Tue, Nov 26, 2002 at 01:29:21PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2002  13:29 -0500, Jeff Dike wrote:
> 	design cleanliness - a UP UML is inherently single-threaded, so it's
> pointless to have many host processes when only one of them can be running.
> A host process maps much more cleanly onto a UML processor than a UML process,
> and a UML process maps much more cleanly onto a host address space than a
> host process.

How does GDB now distinguish between UML processes?  Previously, with
GDB and UML one would "det; att <host pid>" to trace another process.
Will there be equivalent functionality in the new setup?

I was just thinking about hacking the UML PID allocation code so that
the UML process PID == host process PID, so that it is easier to debug
multiple kernel threads (which are all called "kernel thread" and are
hard to align with a specific UML kernel thread).

Will SMP UML "just" be a matter of forking the host process and sharing
the /proc/mm file descriptors, along with a UML SMP scheduler and some
IPC to decide which host process is running each UML process?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

