Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbSJNLWw>; Mon, 14 Oct 2002 07:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSJNLWw>; Mon, 14 Oct 2002 07:22:52 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:38393 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id <S261383AbSJNLWu>; Mon, 14 Oct 2002 07:22:50 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB9D4252@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Problems diagnosing hard lockups in linux kernel
Date: Mon, 14 Oct 2002 12:31:31 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys,

We are having real trouble diagnosing a hard lockup that we are seeing on
our platform, which is based around the Natsemi Geode GX1 plus 5530A
companion chip.  Also present on the board is a MacPhyter DP83815 rev C
ethernet controller, and an IC Ensemble Envy 24 PCI-i2s controller.

Our previous distro of software for the platform was based around RedHat 6.1
+ newer GLIBC(RH71) (to fix PTHREADs buggyness).  The kernel in use was
Linux 2.4.17 + a couple of very trivial cosmetic patches + the NatSemi
framebuffer driver.  This combination works great.  

We wanted to switch to a RedHat 7.3 based system as we were slightly
uncomfortable about running with everything compiled against a different
GLIBC to that installed.  We kept the kernel and all drivers exactly the
same, and changed just the RedHat RPMS.  Now we are seeing hard lockups on
our boxen after around 12-20 hours!  The lockup is severe;  caps lock is
dead, as is ping.  There is no OOPS. 

In our attempts to debug this (now ongoing for 3 weeks) we've tried the
following:

* Upver kernel to latest 2.4.19 + 2.4.20preX patches incase we were seeing a
known bug
* Compile kernel with kgdb and MagicSysRq - neither of which we can actually
get into as the lock is so severe
* Run without the National framebuffer - similar frequency of locks is seen.
Also see the problem when using VESA fb.  
* change kernel compiler 

We don't see this failure on other hardware - or at least not at anywhere
near this level of incidence - hence we are suspecting that this is a kernel
level lock, which is only now being exposed by the different utilization
patterns created by the new userland stuff.  

The only thing that seems to fix things at the moment is the complete
removal of all the userland stuff... less than ideal for our application :-)

Does anyone have any clue as to other ways we can investigate the lock when
it occurs?  Are there any "hired guns" out there who would would be
available to help us out with this?

Thnaks in advance for any suggestions;


James Finnie




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


