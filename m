Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTJCWfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbTJCWfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:35:30 -0400
Received: from mail.cs.uic.edu ([131.193.32.31]:32743 "EHLO mail.cs.uic.edu")
	by vger.kernel.org with ESMTP id S261411AbTJCWfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:35:10 -0400
Date: Fri, 3 Oct 2003 17:34:41 -0500 (CDT)
From: Kevin Kahley <kkahley@cs.uic.edu>
To: linux-kernel@vger.kernel.org
Subject: exclusive memory held by a process
Message-ID: <Pine.GSO.4.10.10310031721300.28068-100000@ernie.cs.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am working with a pc system that has no swap space and no hard disk.
I have direct control over 3 processes on this system and need to
guarantee that they never use more than 190 MB of memory.  I have been
getting the information about memory usage from /proc/*pid*/status but can
not seem to make exact sense of what it is reporting.  Here are the values
I am getting:

Name:	g
State:	S (sleeping)
Tgid:	292
Pid:	292
PPid:	284
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	256
Groups:	
VmSize:	    7772 kB
VmLck:	    7772 kB
VmRSS:	    7772 kB
VmData:	    4284 kB
VmStk:	      32 kB
VmExe:	    1028 kB
VmLib:	    1760 kB
SigPnd:	0000000000000000
SigBlk:	0000000080000000
SigIgn:	0000000000010000
SigCgt:	0000000380000000
CapInh:	0000000000000000
CapPrm:	00000000fffffeff
CapEff:	00000000fffffeff


Name:	s
State:	S (sleeping)
Tgid:	288
Pid:	288
PPid:	287
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	32
Groups:	
VmSize:	   83248 kB
VmLck:	   83248 kB
VmRSS:	   83244 kB
VmData:	   81256 kB
VmStk:	      20 kB
VmExe:	      84 kB
VmLib:	    1760 kB
SigPnd:	0000000000000000
SigBlk:	0000000080000000
SigIgn:	0000000000000000
SigCgt:	7ffffffffffbfeff
CapInh:	0000000000000000
CapPrm:	00000000fffffeff
CapEff:	00000000fffffeff


Name:	v
State:	S (sleeping)
Tgid:	248
Pid:	248
PPid:	1
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	32
Groups:	
VmSize:	   85576 kB
VmLck:	   85576 kB
VmRSS:	   77436 kB
VmData:	   74780 kB
VmStk:	      20 kB
VmExe:	     476 kB
VmLib:	    2452 kB
SigPnd:	0000000000000000
SigBlk:	0000000080000000
SigIgn:	0000000000000000
SigCgt:	00000003e78074ff
CapInh:	0000000000000000
CapPrm:	00000000fffffeff
CapEff:	00000000fffffeff


I have read in many places that VmSize is the total in-memory size of the
running process, but does this include memory that is being shared?  I
thought about adding VmRSS, VmData, and VmStk, but that is greater than
VmSize?   Can anyone tell me what is the amount of memory solely used by a
process?  It's my understanding that my system should crash if these three
processes exceed 190 MB, but using /proc/*pid* values does not confirm
this...

please CC me on any responses:  kkahley@cs.uic.edu

Thank you much in advance.

