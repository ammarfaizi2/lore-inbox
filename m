Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBFQef>; Tue, 6 Feb 2001 11:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBFQeZ>; Tue, 6 Feb 2001 11:34:25 -0500
Received: from bart.graz.inode.at ([195.58.172.139]:14603 "EHLO
	bart.graz.inode.at") by vger.kernel.org with ESMTP
	id <S129055AbRBFQeL>; Tue, 6 Feb 2001 11:34:11 -0500
Message-ID: <3A8027B8.239AA125@graz.inode.at>
Date: Tue, 06 Feb 2001 17:35:04 +0100
From: Alois Martin Hopfer <louis@graz.inode.at>
Organization: Inode Graz
X-Mailer: Mozilla 4.73 [de] (Windows NT 5.0; U)
X-Accept-Language: de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: stuck on TLB IPI wait (CPU#0)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today one of our mailserver crashed with some nifty messages
in the logfile:

Feb  6 15:17:25 mx kernel: stuck on TLB IPI wait (CPU#0)
Feb  6 15:17:25 mx kernel: eth0: card reports no resources.
Feb  6 15:20:18 mx kernel: Adapter 0: Host Drive 1: resetted locally
Feb  6 15:20:18 mx kernel: stuck on TLB IPI wait (CPU#1)
Feb  6 15:20:18 mx kernel: eth0: card reports no resources.
Feb  6 15:20:18 mx kernel: stuck on TLB IPI wait (CPU#1)
[..]
Feb  6 15:24:49 mx kernel: eth0: card reports no resources.
Feb  6 15:24:49 mx kernel: stuck on TLB IPI wait (CPU#1)
Feb  6 15:24:49 mx kernel: eth0: card reports no resources.     
[crash at about 15:25]

The server uses two Pentium III (Coppermine) CPUs whith 800 MHz, 
512 MB ECC Kingston RAM, 
 a SCSI storage controller: VORTEX Unknown device (rev 0).
      Vendor id=1119. Device id=167.  
we use Reiserfs on all Harddisks.
Ethernet controller: Intel 82557 (rev 8).

Base System is Linux Suse 7.0 but most of programs are
compiled. Kernel 2.2.17 with Reiserfs Patch 3.5.27. We're
running exim as MTA with MySQL and qpopper.

When searching for the reason of this crash, we´ve found
some messages, that say, that it is possible that the two
cpus are spinning up together. Others said, this is a bug
initiated by reiserfs, but that it should be fixed in 
Kernel 2.2.13. Can somebody tell me whats the
real reason? 

When the crash occoured, the server wasn´t really under
heavy load (about 1/2 Mbit output with qpopper). The server
is in use now for about one week.

However, are there any solutions to prevent us from this
things? Should we upgrade to Kernel 2.4.x, or could we
to some other things. We think the reset button isn´t the
ultimate solution =;)

Greetings from Austria
--- Louis ---

-- 
Hopfer Alois Martin
System Engineer/Inode Graz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
