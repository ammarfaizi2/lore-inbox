Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbULZJoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbULZJoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 04:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbULZJoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 04:44:13 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:33506 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261551AbULZJoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 04:44:06 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: amanda-users@amanda.org
Subject: amanda oddments of recent occurance
Date: Sun, 26 Dec 2004 04:43:54 -0500
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412260443.55711.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.205.45.252] at Sun, 26 Dec 2004 03:44:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, and I hope everybody had a very happy Christmas.

For some odd reason, I've had several instances of amandad turning a 
pair of copies of itself into zombies or something here on the server 
box, evidenced by getting an email report and printout that lists 
only the client, and not the servers stuff.  It happened again 
tonight, so I killed them, but could not run anything amanda related 
as it claimed the server was not responding as a client.  I also note 
that kpm wouldn't connect to the system to monitor things, claiming 
that the dcopserver apparently wasn't running.  htop did just fine 
however.  So I rebooted and now the missed backup is proceeding 
apparently normally, with one head scratcher showing up in an 
amstatus report, from a section of it:

coyote:/usr/dlds-misc/FC3-i386-disk2.iso           1      637m wait 
for dumping
coyote:/usr/dlds-misc/FC3-i386-rescuecd.iso        0       76m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disc1.iso 1      562m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disk2.iso 0      562m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disk3.iso 0      562m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-SRPMS-disk4.iso 0      562m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-disc1.iso       1      617m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-disk3.iso       1      636m wait 
for dumping
coyote:/usr/dlds-misc/FC3/FC3-i386-disk4.iso       1      386m wait 
for dumping

Looks normal at first glance, but wait, there is more!  Those first 2 
iso images are not *in* the /usr/dlds-misc directory as shown but are 
in fact in the /usr/dlds-misc/FC3 directory as the other 7 images 
shown correctly. 

?????????????????

This was after just over 24 hours of uptime with the brand new 2.6.10 
kernel.  Previous to that, I'd been running 2.6.10-rc3-mm1-V0.33-04 
for over a week, this being the realtime-preemptable patches Ingo 
Molnar is working on.  I might add that they appeared to work quite 
well, with the machine remaining much more responsive from the 
keyboard while amanda was running, or while kmail was doing a mail 
fetch compared to how its acting now.  Running 2.6.10, I've had lags 
of over a minute between what I type, and its appearance on the 
screen if kmail is doing a fetch or amanda has a few copies of gzip 
running.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
