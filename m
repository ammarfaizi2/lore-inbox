Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132875AbRDQVsr>; Tue, 17 Apr 2001 17:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132879AbRDQVsi>; Tue, 17 Apr 2001 17:48:38 -0400
Received: from mail.gci.com ([205.140.80.57]:43538 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S132875AbRDQVs3>;
	Tue, 17 Apr 2001 17:48:29 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446DA39@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 13:48:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Jesse Pollard replies:
> > to Leif Sawyer who wrote: 
> > >> Besides, what would be gained in making the counters RO, if 
> > >> they were cleared every time the module was loaded/unloaded?
> > > 
> > > 1. Knowlege that the module was reloaded.
> > > 2. Knowlege that the data being measured is correct
> > > 3. Having reliable measures
> > > 4. being able to derive valid statistics
> > > ....
> > 
> > Good.  Now that we have valid objectives to reach, which of these
> > are NOT met by making the fixes entirely in userspace, say by
> > incorporating a wrapper script to ensure that no external 
> applications
> > can flush the table counters?
> > 
> > They're still all met, right?
> 
> Nope - some of the applications that may be purchased do not have
> to go through the scripts to reset the counters. They just need access
> to the counters, and reset is built into the applications. 
> This violates
> all 4 objectives.
> 
> > And we haven't had to fill the kernel with more cruft.
> 
> Removing/no-oping the reset code would make the module
> SMALLER, and simpler.
> 

NO.  Don't remove the functionality that is required.  Fix your
userspace applications to behave correctly.  If _you_ require your
userspace applications to not clear counters, then fix the application.

The counters are not gospel.  The modules are not omnipresent.

Time and again, people beg and plead the kernel developers to change
the kernel to suit their personal biases and applications.  Historically
they have been vehemently against it.  Of what purpose does breaking EVERY
application out there by performing this kernel mod have?

As Matti Aarnio points out, this is nearly beaten to death.  Since none
of the 'Big Boys' have commented, my guess is that this is a moot argument,
and no changes to the kernel will take place.

/me steps off of soapbox
/me retires this thread

 
