Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129585AbQLEIPM>; Tue, 5 Dec 2000 03:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbQLEIPC>; Tue, 5 Dec 2000 03:15:02 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52752 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129585AbQLEIOq>; Tue, 5 Dec 2000 03:14:46 -0500
Date: Tue, 5 Dec 2000 01:43:41 -0600
To: Peter.Ronnquist@nokia.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: shared memory, mmap not recommended?
Message-ID: <20001205014340.C6567@cadcamlab.org>
In-Reply-To: <9524EA4E18D6D2119FEA0008C7C5A006BE4A77@lneis01nok>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <9524EA4E18D6D2119FEA0008C7C5A006BE4A77@lneis01nok>; from Peter.Ronnquist@nokia.com on Tue, Dec 05, 2000 at 09:36:50AM +0200
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  [Linus]
> > (otherwise I'll just end up disabling shared mmap - I doubt anybody
> > really uses it anyway, but it would be more polite to just support
> > it).

[Peter Rönnquist]
> I was thinking about using mmap for shared mememory in my program,
> but now I am reconsidering.  Is the System V or Posix mechanism for
> shared memory a better(it will be supported in 2.4) choice?

Linus was talking about shared mmap on a file in an smbfs filesystem.
Rather different from what you are talking about.  For regular shared
memory, shared mmap should be OK if you actually need backing store
(i.e. the state you are sharing is persistent).  Often this is not the
case, in which case POSIX shm might be best.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
