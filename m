Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUILP2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUILP2p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268114AbUILP2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:28:45 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:64419 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S268108AbUILP2l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 11:28:41 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: journal aborted, system read-only
Date: Sun, 12 Sep 2004 11:28:39 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409121128.39947.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.56.63] at Sun, 12 Sep 2004 10:28:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just got up, and found advisories on every shell open that the 
journal had encountered an error and aborted, converting my / 
partition to read-only.

Rebooting was a mess of course, and it didn't take long for it to 
report corruption in /dev/hda7, my / partition, and to drop me to a 
shell for manual intervention if I knew my password.

An e2fsck /dev/hda7 reported problems with about a dozen inodes, and 
essentially I stood on the y key, but once that was done, the reboot 
was clean.  I've no idea whats missing if anything at this point.

The kernel is 2.6.9-rc1-mm4.  .config available on request.

I had been playing with amanda, essentially restarting it from scratch 
each time as I played with a virtual tapes on disk configuration on 
that new 200GB disk, but the target disk wasn't trashed that I know 
of, but the amanda run was aborted due to the read-only nature of its 
holding disk, which is a dir on /.  Nothing precious was lost there 
because I'll probably have to restart it from scratch again to clean 
up the mess of an aborted run anyway.

But it is inconvienient to lose a days experimental data.

FWIW, I have a *large* UPS, and my local electrical power supply 
hasn't been that great over the last month, averaging around 1, 2 
second power outage per day at random times that don't seem to be 
connected with the weather.  I mention this because the Bulldog 
monitoring program throws up advisory windows on every screen 
advising that an automatic shutdown will start in 5 minutes, and then 
use that same advisory window to report that power has been restored.

There was one such advisory window open on every X screen.

Checking the logs, there is of course nothing between the read-only 
event, and the reboot.  From it:
=========
Sep 12 04:54:58 coyote su(pam_unix)[17131]: session closed for user 
news
=========
The test amanda run was cron started at 4:55 AM, and I played a few 
games of solitaire before going back to bed, also my nightime 
'burgular alarm' mode of the X-10 stuff was put back in daytime mode 
at 5:00 AM
=========
Sep 12 05:00:00 coyote heyu_relay: interrupt received
Sep 12 05:00:01 coyote heyu_relay: relay setting up-
=========
I shut down solitaire and went back to bed
=========
Sep 12 05:20:56 coyote gconfd (root-14600): GConf server is not in 
use, shutting down.
Sep 12 05:20:57 coyote gconfd (root-14600): Exiting
Sep 12 10:58:17 coyote syslogd 1.4.1: restart.
=========

This is precious little info to go on, but basicly I'm wondering if 
anyone else has encountered this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
