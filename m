Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSF0M5c>; Thu, 27 Jun 2002 08:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSF0M5b>; Thu, 27 Jun 2002 08:57:31 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:14100 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S316837AbSF0M5a>; Thu, 27 Jun 2002 08:57:30 -0400
Date: Thu, 27 Jun 2002 07:57:19 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200206271257.HAA61267@tomcat.admin.navo.hpc.mil>
To: dax@gurulabs.com, Michael Kerrisk <m.kerrisk@gmx.net>
Subject: Re: Status of capabilities?
In-Reply-To: <1025157926.1652.35.camel@mentor>
Cc: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com>:

> 
> On Wed, 2002-06-26 at 06:40, Michael Kerrisk wrote:
> 
> > What's still missing in 2.4, as far as I can see after reading the sources,
> > is the ability to set capabilities on executable files so that a process
> > gains those privileges when executing the file.  I recall seeing some
> > information somewhere saying this wasn't possible / wasn't going to happen
> > for ext2.  Is it on the drawing board for any file system?
> 
> The 2.5 VFS supports Extended Attributes (since 2.5.3). I think the plan
> was use EAs to store capabilities. So I believe that the infrastructure
> is in place, someone with the proper skills just needs to:
> 
> 1. Define how capabilities will be stored as a EA
> 2. Teach fs/exec.c to use the capabilities stored with the file
> 3. Write lscap(1)
> 4. Write chcap(1)
> 5. Audit/fix all SUID root binaries to use capabilities
> 6. Set appropriate capabilities with for each with chcap(1) and then:
>    # find / -type f -perm -4000 -user root -exec chmod u-s {} \;
> 7. Party and snicker in the general direction of that OS with the slogan
> "One remote hole in the default install, in nearly 6 years!"

Actually, I think most of that work has already been done by the Linux
Security Module project (well, except #7).

see:
	http://lsm.immunix.org/

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
