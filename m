Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267786AbTB1PDC>; Fri, 28 Feb 2003 10:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267938AbTB1PDC>; Fri, 28 Feb 2003 10:03:02 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27279 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267786AbTB1PDB>;
	Fri, 28 Feb 2003 10:03:01 -0500
Date: Fri, 28 Feb 2003 20:48:31 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030228204831.A3223@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1046238339.1699.65.camel@laptop-linux.cunninghams> <20030227181220.A3082@in.ibm.com> <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com> <20030228134406.GA14927@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030228134406.GA14927@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Fri, Feb 28, 2003 at 02:44:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 02:44:06PM +0100, Pavel Machek wrote:
> > Atomic snapshots are what we'd like for dump too, since we desire 
> > accurate dumps (minimum drift), so its not a conflicting requirement. 
> > The difference is that while you could do i/o (e.g to flush pages 
> > to free up memory) before initiating an atomic snapshot, we can't.
> 
> OTOH "best-effort-atomic" is probably okay for you, while it is not
> acceptable for swsusp. Hopefully the code is not going to get too
> complicated by "must be atomic" and "must work with crashed system"
> requirements...
> 
For the kind of atomicity you need there probably are two
steps:
1) Quiesce the system - get to a point of consistency (when you
   can take a resumable snapshot)
2) Perform an atomic copy / snapshot

Step (1) would be different for swsusp and crash dump (not
intended to be common ). But for Step (2), do you think
what you need/do is complicated by crashed system requirements ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

