Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbRDQVZy>; Tue, 17 Apr 2001 17:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132867AbRDQVZp>; Tue, 17 Apr 2001 17:25:45 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:37749 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132864AbRDQVZf>; Tue, 17 Apr 2001 17:25:35 -0400
Date: Tue, 17 Apr 2001 16:25:32 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104172125.QAA09568@tomcat.admin.navo.hpc.mil>
To: lsawyer@gci.com, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Ian.Stirling@tomcat.admin.navo.hpc.mil, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> Jesse Pollard replies:
> to Leif Sawyer who wrote: 
> >> Besides, what would be gained in making the counters RO, if 
> >> they were cleared every time the module was loaded/unloaded?
> > 
> > 1. Knowlege that the module was reloaded.
> > 2. Knowlege that the data being measured is correct
> > 3. Having reliable measures
> > 4. being able to derive valid statistics
> > ....
> 
> Good.  Now that we have valid objectives to reach, which of these
> are NOT met by making the fixes entirely in userspace, say by
> incorporating a wrapper script to ensure that no external applications
> can flush the table counters?
> 
> They're still all met, right?

Nope - some of the applications that may be purchased do not have
to go through the scripts to reset the counters. They just need access
to the counters, and reset is built into the applications. This violates
all 4 objectives.

> And we haven't had to fill the kernel with more cruft.

Removing/no-oping the reset code would make the module
SMALLER, and simpler.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
