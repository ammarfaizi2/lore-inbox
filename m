Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277022AbRJCXgK>; Wed, 3 Oct 2001 19:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277023AbRJCXf7>; Wed, 3 Oct 2001 19:35:59 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:10250 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S277022AbRJCXfv>; Wed, 3 Oct 2001 19:35:51 -0400
Date: Thu, 4 Oct 2001 01:36:09 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Minor update for REPORTING-BUGS
Message-ID: <20011004013609.B25906@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now both 2.4.11-pre2 and linux-2.4.10-ac4 have support support for
/proc/sys/kernel/tainted, it's time to update REPORTING-BUGS to
reflect this change. Here is a patch for this:


Index: REPORTING-BUGS
===================================================================
RCS file: /home/erik/cvsroot/elinux/REPORTING-BUGS,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 REPORTING-BUGS
--- REPORTING-BUGS	2001/04/26 12:28:10	1.1.1.15
+++ REPORTING-BUGS	2001/10/03 23:25:44
@@ -20,6 +20,12 @@
 linux-kernel@vger.kernel.org. (For more information on the linux-kernel
 mailing list see http://www.tux.org/lkml/).
 
+      Note that the kernel maintainers are not interested in bug
+reports that could be caused by the use of binary-only kernel
+modules. To see if your kernel has not been using binary modules, use
+"cat /proc/sys/kernel/tainted". If the output is "0", you can safely
+send your bug report to the maintainers.
+
 This is a suggested format for a bug report sent to the Linux kernel mailing 
 list. Having a standardized bug report form makes it easier  for you not to 
 overlook things, and easier for the developers to find the pieces of 


The patch should apply cleanly against 2.4.11-pre2 and 2.4.10-ac4.
Please apply.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
