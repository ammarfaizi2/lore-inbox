Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264477AbRFZVJs>; Tue, 26 Jun 2001 17:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRFZVJ3>; Tue, 26 Jun 2001 17:09:29 -0400
Received: from asooo.flowerfire.com ([63.104.96.247]:7951 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S264477AbRFZVJX>; Tue, 26 Jun 2001 17:09:23 -0400
Message-Id: <200106262109.QAA15955@asooo.flowerfire.com>
Date: Tue, 26 Jun 2001 14:09:16 -0700
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v388)
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.388)
Content-Transfer-Encoding: 7bit
Subject: Tracking down semaphore usage/leak
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With RedHat's new Samba 2.0.10 RPM (the one to patch the latest 
vulnerability) they seem to have sniffed enough glue to start using SysV 
IPC semaphores which apparently leak until SEM??? are reached.  semget() 
is returning "No space left on device", and disk/inodes/memory are all 
fine.

Anyway, could someone give me a very quick rundown of the options for 
tracking/force-freeing semaphores, or how to determine from proc, if 
possible, what the current semaphore allocation status is?  Or did RH 
slay a machine I really don't want to reboot?  I've restarted all 
semaphore-using processes to no avail, but even so the SEM??? limits are 
far above the normal needs of this machine.

Thanks much.  Searched the archives/Google/FAQ/semaphore docs; sorry if 
it's been covered.  I'll summarize if folks want to hit me on or off the 
list.
--
Ken.
brownfld@irridia.com
