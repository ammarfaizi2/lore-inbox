Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRC0G2M>; Tue, 27 Mar 2001 01:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130552AbRC0G2C>; Tue, 27 Mar 2001 01:28:02 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:44807 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S130532AbRC0G1v>;
	Tue, 27 Mar 2001 01:27:51 -0500
Date: Tue, 27 Mar 2001 01:27:09 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 386 'ls' gets SIGILL iff /proc is mounted
Message-ID: <20010327012709.I59@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.2-ac23 nfsroot on a 386SX/20 with 6Mb RAM

On boot to single user, 'ls' and 'ls -l' work fine.

After mounting /proc, 'ls' still works, but 'ls -l' fails
with SIGILL after reading /etc/timezone (so says strace).

Unmounting /proc fixes the problem. Unmounting /dev doesn't.

I also, just now, had a spate of 'permission denied' errors
while trying to ls /dev/ subdirectories, and unexpected stale NFS handles.

The problems are varied enough that I suspect bad hardware, but would
flaky RAM cause such similar failures repeatedly? And is there a way
to test RAM explicitly?

Any tips appreciated, either to me (ebuddington@wesleyan.edu) or to
the list.

-Eric

