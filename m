Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSGVKVB>; Mon, 22 Jul 2002 06:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316629AbSGVKVB>; Mon, 22 Jul 2002 06:21:01 -0400
Received: from mail6.svr.pol.co.uk ([195.92.193.212]:16176 "EHLO
	mail6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316623AbSGVKU7>; Mon, 22 Jul 2002 06:20:59 -0400
Date: Mon, 22 Jul 2002 11:23:42 +0100
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020722102342.GE1196@fib011235813.fsnet.co.uk>
References: <3D361091.13618.16DC46FB@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D361091.13618.16DC46FB@localhost>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:49:21AM -0400, Guillaume Boissiere wrote:
> o EVMS (Enterprise Volume Management System)      (EVMS team)
> o LVM (Logical Volume Manager) v2.0               (LVM team)

Some comments on the 'EVMS vs LVM2' threads:

I am only petitioning for the driver called 'device-mapper' to be
included in the kernel.  This is a *much* lower level volume manager
than either the EVMS or LVM1 drivers.  I am *not* petitioning for EVMS
not to be included.

People are getting understandably confused between device-mapper and
LVM2:

*) device-mapper is a driver, intended to provide an extensible (via
   the definition of new targets) framework capable of support
   *anything* that volume management applications should want to do.

*) LVM2 is a userland application that uses the device-mapper driver to
   provide a set of tools very similar to LVM1.  Currently LVM2 is the
   only userland application that uses this driver, leading people to
   associate the two far too strongly.

It would be good if other volume managers embrace device-mapper
allowing us to work together on the kernel side, and compete in
userland.  Kernel development takes *far* too much manpower for us to
be duplicating work.  For example I released the LVM2 vs EVMS snapshot
benchmarks in the hope of encouraging EVMS to move over to
device-mapper, unfortunately 2 months later a reply is posted stating
that they have now developed equivalent (but broken) code :(

Sistina and IBM *are* both competing with their volume managers, but I
feel that this competition should be occuring in userland - and
certainly is not relevant to this list.  For instance EVMS appears to
do Volume + FS management whereas LVM2 does just volume management -
in no way does device-mapper preclude FS management, yet that is the
impression that some of the postings to the list have been giving.

- Joe
