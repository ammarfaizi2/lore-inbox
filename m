Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTFWEDF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 00:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbTFWEDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 00:03:05 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:61316 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265300AbTFWEDC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 00:03:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.21-ck3
Date: Mon, 23 Jun 2003 14:17:25 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306231418.12060.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Updated patchset.

http://kernel.kolivas.org

Contains:
O(1) + batch scheduling
Interactivity changes
Preempt
Low Latency
CK VM hacks
Swap Prefetch
Read Latency2
Variable HZ
Scheduler tunables
Supermount-NG v1.2.7
XFS file system 1.3.0pre2
ACPI 20030522
Nvidia Nforce2
Bootsplash 
Grsec 1.9.9h

available, less tested, incomplete, or b0rken:
Packet writing for cdrw/dvd-r
CPU Frequency scaling
Software Suspend

Other VMs (yet to be resynced to ck3, but will be soon):
AA VM
Rmap15j

Changes:
I've added my interactivity changes to this one to improve system 
responsiveness, and virtually eliminate audio/video skipping, and to retain X 
interactivity under load (see threads in lkml for full discussion of 
sleep_decay patch).
Timeslices have been restored to their larger values and the interactive feel 
helped by granularity at 10ms.
The scheduler code has been tidied up now that I had been looking at it for so 
long working on my additions I couldn't stand it being untidy.
HZ has been tuned now to 1000 as the above changes make this value not cause 
the jerkiness evident in most 1000Hz kernels. The advantage is much lower 
absolute latencies (see website for benchmarks.)
The extra patches have been incorporated into the full patch now that I've had 
people testing them and bugfixes have been included.
Packet writing is available again separately.

What happened to ck2? Long story involving not enough sleep and posting a dud 
patch. This is what ck2 was supposed to be...

Thanks to all those people who have been aggressively testing the ck2 pre 
patches, and those sending me patch cleanups.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9n9YF6dfvkL3i1gRAnvBAJ4oYKziAUmvCA8zal7dRKB0w7B+RQCeMKZ+
3mAGOFvFKY1G13U/DpEK/0I=
=D1Iq
-----END PGP SIGNATURE-----

