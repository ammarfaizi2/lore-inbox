Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267344AbSLERSv>; Thu, 5 Dec 2002 12:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLERSu>; Thu, 5 Dec 2002 12:18:50 -0500
Received: from ahriman.bucharest.roedu.net ([141.85.128.71]:57250 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S267344AbSLERSt>; Thu, 5 Dec 2002 12:18:49 -0500
Date: Thu, 5 Dec 2002 19:44:09 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: disabling NMI events for kdb 2.1
Message-ID: <Pine.LNX.4.33.0212051935590.16762-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am using kdb 2.1 to hunt down a bug. This bug shows up after like 2 days
of uptime. Problem is that also on this system I get a unkown reason NMI
like:

Uhhuh. NMI received for unknown reason 21.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?

When it happens it enters kdb mode, thus the system "freezes".
Because I cannot be there to issue a "go" everytime it happens (line 4 am
:) ), it makes very hard to keep kdb enabled kernel running to wait for
the hunted bug to happen.

Is there a possibility to disable going to kdb mode when a "unkown reason"
NMI is received ? I could not find any usefull info in the kdb docs.

PS: this is the output from kdb on serial console when it receives the
NMI:
Entering kdb (current=0xcf142000, pid 31088) on processor 0 due to NonMaskable 3
eax = 0x00000051 ebx = 0x0804ebb0 ecx = 0x40017000 edx = 0x00000000
esi = 0x00000042 edi = 0x0804ebf8 esp = 0xbfffe094 eip = 0x08048fe3
ebp = 0xbfffe0ac xss = 0x0000002b xcs = 0x00000023 eflags = 0x00000202
xds = 0x0000002b xes = 0x0000002b origeax = 0x00000051 &regs = 0xcf143fc4

Thanks

----------------------------
Mihai RUSU


