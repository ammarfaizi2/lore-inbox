Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFOFOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 01:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFOFOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 01:14:48 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:42913 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S261874AbTFOFOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 01:14:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.21-ck1
Date: Sun, 15 Jun 2003 05:28:30 +0000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306150528.30511.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First formal release of ck patchset available for 2.4.21.

http://kernel.kolivas.org

Includes:
O(1) with batch scheduler
Preemptible
Low Latency
CK VM hacks
Read Latency2
Variable Hz
Scheduler Tunables
Desktop Tweaks to the above

extras available but not included in patchset for size and simplicity:
Supermount v1.2.7
XFS filesystem
ACPI
Nvidia Nforce2 update
Bootsplash
Swap Prefetching
CPU freq
GRsec1.9.9h

Optional VMs:
Latest AA VM addons
Rmap15j

Still broken but available by request.
Software Suspend
2.5 Interactivity changes

Changes since 2.4.20-ck7:
Resync with 2.4.21
I've modified the batch scheduler code to automatically make any userspace 
task that starts priority >18 as BATCH. More people will benefit from the 
batch scheduling feature without having to use the schedtools.
The autoregulation changes to the default VM (affectionately known as CKVM 
even though it's only minor hacks to the 2.4 VM) has been reworked. It tries 
hard to avoid swapping out application pages unless your ram is full of 
applications and will cache data very aggressively when there is ram 
available. 
Read Latency 2 has been reintroduced after a short absence when the elevator 
fixes were found, as RL2 seems to help in other areas. The desktop tuning for 
this is a little less aggressive now that the elevator has been tamed.

I left out the rest of the patches to minimise my bandwidth usage and let 
people pick and choose as often they only desire one of the following.
Supermount is now the latest v1.2.7.
XFS is a later snapshot. * Please test as I can't test this myself *.
ACPI is snapshot 20030522
Bootsplash has been added and tested.
GRsec 1.9.9h has been ported to -ck by popular demand. It remains untested but 
compiles ok.
The AA VM addons were updated to the latest available. A fix for the 
combination of AAVM and XFS is also available.
Rmap was updated to 15j

Another attempt at including software suspend has been unsuccessful. The code 
compiles and boots ok but will trash a FS if you try to suspend. This is on 
the website just for interest at the moment.

The FAQ has been updated as more Q become FA.
Lots of older stuff has been removed from my website.

Please test this one carefully.
The patches that have been extensively tested so far are the default patch, 
supermount, acpi, bootsplash and swap prefetch. The other patches need more 
in the field testing.

Feel free to send me comments, queries, suggestions, patches, bug-reports etc, 
but _first_ read the FAQ.

Regards,
Con Kolivas

