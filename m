Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbTCEVAE>; Wed, 5 Mar 2003 16:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTCEVAE>; Wed, 5 Mar 2003 16:00:04 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:19193 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S263333AbTCEVAD>; Wed, 5 Mar 2003 16:00:03 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: linux-kernel@vger.kernel.org
Subject: system lockup issues w/ 2.4.19
Date: Wed, 5 Mar 2003 13:10:25 -0800
User-Agent: KMail/1.5
Organization: Cast & Crew Entertainment Services, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303051310.25812.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if anyone here might be able to point me in the right 
direction for a solution to this problem.

About once a month or so (not very regular), one or the other of our Dell 
PowerEdge servers goes catatonic.  Examining the system in this state, it 
seems to exhibit the symptoms of a full process table, in that no new 
processes can be started at all.  This results in a system that has a 
completely unresponsive console, services which answer to new connections 
but never do anything, and general frustration as the only sign of life at 
all is that it'll respond to pings.

Investigation after a power cycle of the catatonic machine reveals that 
processes that had been running at the time of the event (whatever the 
event is) either kept running (in the case of services, like syslog) or ran 
to normal completion (i.e., reports or other jobs that had been started 
earlier).  As I said, everything I've gleaned from these systems when 
they've gone catatonic suggests a full process table, but I have no proof 
of it.

One of these servers (where it's more critical that this not happen) is a 
Dell PowerEdge 6600, 4x 1.6GHz Xeon, 8GB ram, dual Broadcom GigE NICs, 
PERC3/DC (Megaraid) Raid controller.  This system is running SuSE Linux 
Enterprise Server 7 (essentially SuSE 7.2 Pro) with kernel 2.4.19 (from 
kernel.org) patched with LVM 1.0.5 (sistina) and "10_inode-highmem-2", a 
patch recommended to me way back when I was trying to take care of some 
LVM/VM issues with bigmem support (which are still unresolved).  This is a 
production machine, and as such my ability to load new kernels and do 
testing is limited, but I can get ahold of it on the weekends.

The other server is our development machine, a Dell PowerEdge 4600, 2x 
2.4GHz Xeon, 2GB ram, e100 and Broadcom GigE NICs, aacraid.  This system is 
also running SuSE Linux Enterprise Server 7, kernel 2.4.19 + LVM 1.0.5, but 
without the highmem patch.

At this point, I'm looking for any options in resolving this issue.  I'm 
goign to be contacting SuSE to open a support ticket, to see if they can 
help.  I'm preparing a 2.4.20 kernel + LVM 1.0.7 which I can hopefully 
install tonight on both machines.  I'm trying to get my hands on one of Red 
Hat's 2.4.20 "bigmem" kernels to see what they include and if maybe one of 
RH's kernels might do the job...  Any other suggestions would be most 
appreciated.

TIA,
Gregory

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

