Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130010AbRAINlo>; Tue, 9 Jan 2001 08:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbRAINle>; Tue, 9 Jan 2001 08:41:34 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:16704 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130010AbRAINlX>; Tue, 9 Jan 2001 08:41:23 -0500
Date: Tue, 9 Jan 2001 07:41:21 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101091341.HAA52016@tomcat.admin.navo.hpc.mil>
To: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: `rmdir .` doesn't work in 2.4
Cc: Alexander Viro <viro@math.psu.edu>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Hello Al,
> 
> why `rmdir .` is been deprecated in 2.4.x?  I wrote software that depends on
> `rmdir .` to work (it's local software only for myself so I don't care that it
> may not work on unix) and I'm getting flooded by failing cronjobs since I put
> 2.4.0 on such machine.  `rmdir .` makes perfect sense, the cwd dentry remains
> pinned by me until I `cd ..`, when it gets finally deleted from disk.  I'd like
> if we could resurrect such fine feature (adapting userspace is just a few liner
> but that isn't the point). Comments?

Not exactly valid, since a file could be created in that "pinned" directory
after the rmdir...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
