Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313730AbSDPPz6>; Tue, 16 Apr 2002 11:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313725AbSDPPz5>; Tue, 16 Apr 2002 11:55:57 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:10575
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313727AbSDPPzz>; Tue, 16 Apr 2002 11:55:55 -0400
Message-Id: <200204161555.g3GFtmH03317@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, davej@suse.de
Subject: [PATCH] i386 arch subdivision into machine types for 2.5.8
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 10:55:48 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch tries to split arch/i386 up into machine specific directories 
(similar to the way arch/arm is done).  The idea is to separate out those 
machines which don't look like standard PCs (particularly from an SMP 
standpoint).  For the current kernel, all it really does is to get the visws 
stuff into a separate directory (arch/i386/visws).  I've also taken some files 
which aren't going to be used by non-pc SMP machines (mainly related to mpbios 
and ioapic) and placed them into arch/i386/generic.

The patch goes much further than visws needs, mainly because it now allows me 
to add my voyager stuff in a separate arch/i386/voyager directory with 
virtually no disturbance of the main line code.  I'm afraid there are also 
still four VISWS defines in arch/i386/kernel/smpboot.c because it wasn't 
obvious to me how to get rid of them simply.

The 269k diff file (large because it has a lot of file moves) is at

http://www.hansenpartnership.com/voyager/files/arch-split-2.5.8.diff

There's also a bitkeeper repository with all this in at

http://linux-voyager.bkbits.net/arch-split-2.5

I haven't done anything about the other half of i386/arch reform which is 
splitting the PC directory up into bus types, but I believe Patrick Mochel is 
thinking about this.

Comments and suggestions welcome.

James Bottomley


