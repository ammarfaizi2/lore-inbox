Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSJ2PVC>; Tue, 29 Oct 2002 10:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSJ2PVC>; Tue, 29 Oct 2002 10:21:02 -0500
Received: from 24-216-100-96.charter.com ([24.216.100.96]:50856 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S261907AbSJ2PVB>;
	Tue, 29 Oct 2002 10:21:01 -0500
Date: Tue, 29 Oct 2002 10:27:23 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: How to diagnose...
Message-ID: <20021029152723.GR3420@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Need some brainstorming from people with a clue.

Hardware:
  4xP3-550
  16Gig of Ram
  1x18Gig internal disk
  4x54Gig RAID Disk
  512Meg swap partition on sda2
  1Gig swap file in /usr/local/swapfile on /dev/sda3

The 4 54Gig disks are in a Raid5 with software raid.

I'm on a vanila 2.4.18 kernel configured for Huge Memory.

This is supposed to be a new corporate mail server but we're having some
issues.  What we have been see'ing the 3-4 times we tried is the Load 
jumps to 9+ and the box drops to a crawl when we rsync the imap folders 
from the old host to the new host.  Last night I readded the 1Gig file 
(it was at 512Meg only) and we started again.  It ran great for about 
2hrs then the box locked up.  I got to the console this morning and it 
was scrolling so fast I couldn't even read it.  It looked like it was 
reporting ACIC errors on a CPU but couldn't quite be sure.  It required 
a hard reset as it was unresponsive to c-a-d and sysreq commands.

There is nothing in the messages file and there was nothing useful on
the console.

"free" shows the rsync eats up alot of memory but never starts to swap
or if it does only swaps less than 30k.


Thoughts?


:wq!
---------------------------------------------------------------------------
Robert L. Harris                
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'

