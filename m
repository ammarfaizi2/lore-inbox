Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRCPHQZ>; Fri, 16 Mar 2001 02:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbRCPHQQ>; Fri, 16 Mar 2001 02:16:16 -0500
Received: from mumm.ibr.cs.tu-bs.de ([134.169.34.190]:29113 "EHLO
	mumm.ibr.cs.tu-bs.de") by vger.kernel.org with ESMTP
	id <S130079AbRCPHQB>; Fri, 16 Mar 2001 02:16:01 -0500
Date: Fri, 16 Mar 2001 08:15:09 +0100
Message-Id: <200103160715.IAA00963@kelts.ibr.cs.tu-bs.de>
From: Joerg Diederich <dieder@ibr.cs.tu-bs.de>
To: dpw@doc.ic.ac.uk
CC: rct@gherkin.sa.wlk.com, davej@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <y7ru24wuffy.fsf@sytry.doc.ic.ac.uk> (message from David Wragg on
	14 Mar 2001 22:57:21 +0000)
Subject: Re: another Cyrix/mtrr problem?
In-Reply-To: <m14d1KU-0005khC@gherkin.sa.wlk.com> <y7ru24wuffy.fsf@sytry.doc.ic.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Wragg writes:

+> rct@gherkin.sa.wlk.com (Bob_Tracy) writes:
+>> Unfortunately, when I execute
+>> 
+>> echo "base=0xd8000000 size=0x100000 type=write-combining" >|
+>> /proc/mtrr
+>> 
+>> I get a 2MB region instead of the 1MB region I expected...

+> Oops, it got broken by the MTRR >32-bit support in 2.4.0-testX.
+> The patch below should fix it.

+> Joerg, I think this might well fix your Cyrix mtrr problem also.

Indeed, it does. XFree 4 does create a region with the right size and
even setting the mtrr manually works perfectly. Although only tested
one evening, there were no 'no mtrr found for...' messages in the
syslog anymore.


Thankx a lot,

/J"org
