Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132813AbRDQScQ>; Tue, 17 Apr 2001 14:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRDQSb6>; Tue, 17 Apr 2001 14:31:58 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:35956 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132815AbRDQSb1>; Tue, 17 Apr 2001 14:31:27 -0400
Date: Tue, 17 Apr 2001 13:31:22 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104171831.NAA78267@tomcat.admin.navo.hpc.mil>
To: lsawyer@gci.com, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Ian.Stirling@tomcat.admin.navo.hpc.mil, <root@mauve.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com>:
> > And that introduces errors in measurement. It also depends on 
> > how frequently an uncontroled process is clearing the counters.
> > You may never be able to get a valid measurement.
> 
> This is true.  Which is why application programmers need to write
> code as if they are not the only [ab]users of data.
> 
> Which brings me back to my point.
> 
> Don't force the kernel to uphold your local application requirements
> of stable counters.
> 
> Enforce it in the userspace portion of the code.
> 
> <subtopic>
> Yes, you could extend the proc filesystem (ugh) with a flag that could
> be read by the ip[chains|tables] user app to determine if clearing flags
> were allowed.  Then a simple
> 
> echo 1 > /proc/sys/net/ipv4/counters_locked
> 
> or some such cruft.  But I don't see this extension making into the
> standard kernel at this time.  It just seems to be wasteful.
> </subtopic>
> 
> If you (at your site) really need this type of functionality, it's
> pretty darn simple to write a wrapper to ip[tables|chains] which
> silently (or not so) drops the option to clear the counters before
> calling the real version.
> 
> Besides, what would be gained in making the counters RO, if they were
> cleared every time the module was loaded/unloaded?

1. Knowlege that the module was reloaded.
2. Knowlege that the data being measured is correct
3. Having reliable measures
4. being able to derive valid statistics
....

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
