Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289767AbSAWKXD>; Wed, 23 Jan 2002 05:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSAWKWo>; Wed, 23 Jan 2002 05:22:44 -0500
Received: from fractus.met.ed.ac.uk ([129.215.133.165]:3486 "EHLO
	fractus.met.ed.ac.uk") by vger.kernel.org with ESMTP
	id <S289767AbSAWKWd>; Wed, 23 Jan 2002 05:22:33 -0500
Date: Wed, 23 Jan 2002 10:22:29 +0000 (GMT)
From: H C Pumphrey <hcp@met.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: nm256 patch for Latitude LS
Message-ID: <Pine.GSO.4.10.10201231005500.11847-100000@humilis>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear all, 

The enclosed patch allows the nm256 kernel module to be used on the Dell
Latitude LS Laptop. Without the patch, the kernel locks up instantly with
no messages as soon as the module is loaded. (This problem has been known
about for a long time -- an ex-LS-owner sent me the patch only yesterday
having seen on my web pages that I would have a use for it.)

With the patch, the hardware seems to work OK. I don't know whether the
"fix" causes a "break" on any other nm256 hardware. I have tested the
patch on kernels 2.2.19 and 2.2.20 -- once I upgrade to Debian testing
I'll try out a 2.4 kernel. I'm posting this now in the hope that this
information might be of use to at least one other nm256 user out there.
It's a darn sight better than the pcsp patch!

Best Wishes.

Hugh

*** nm256_audio.c.old	Sun Sep 30 12:26:08 2001
--- nm256_audio.c	Sun Dec 16 23:02:34 2001
***************
*** 896,902 ****
  
      /* Reset the mixer.  'Tis magic!  */
      nm256_writePort8 (card, 2, 0x6c0, 1);
-     nm256_writePort8 (card, 2, 0x6cc, 0x87);
      nm256_writePort8 (card, 2, 0x6cc, 0x80);
      nm256_writePort8 (card, 2, 0x6cc, 0x0);
  
--- 896,901 ----

============S=u=p=p=o=r=t===D=e=b=i=a=n===http://www.debian.org============
Dr. Hugh C. Pumphrey             | Tel. 0131-650-6026,Fax:0131-650-5780
Institute for Meteorology        | Replace 0131 with +44-131 if outside UK
The University of Edinburgh      | Email hcp@met.ed.ac.uk
EDINBURGH EH9 3JZ, Scotland      | URL: http://www.met.ed.ac.uk/~hcp
============S=u=p=p=o=r=t==g=9=5==http://g95.sourceforge.net/==============

