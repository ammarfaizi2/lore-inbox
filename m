Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290550AbSBOSS2>; Fri, 15 Feb 2002 13:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290547AbSBOSST>; Fri, 15 Feb 2002 13:18:19 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:23503 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S290550AbSBOSSD>; Fri, 15 Feb 2002 13:18:03 -0500
Date: Fri, 15 Feb 2002 12:17:58 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200202151817.MAA28366@tomcat.admin.navo.hpc.mil>
To: l.allegrucci@tiscalinet.it, linux-kernel@vger.kernel.org
Subject: Re: Redundant syscalls?
In-Reply-To: <02021517152700.01701@odyssey>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> 
> I was wondering why do we need fsetxattr(2), fgetxattr(2) etc when we 
> already have setxattr(2), getxattr(2) etc working on file names
> instead of file descriptors.
> truncate(2)/ftruncate(2) is another more traditional example.

Atomic actions.

Consider the case of a file that doesn't exist yet. first you
open it, then perform the fsetxattr. If you use the name, then it becomes
possible to rename the file and substitute a different one before the
setxattr. Now, the open file will be missing the attribute(s).
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
