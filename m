Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTEZGeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 02:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTEZGeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 02:34:03 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:10645 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264281AbTEZGeC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 02:34:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ck7
Date: Mon, 26 May 2003 16:48:54 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305261649.02132.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's an update to my patchset

http://kernel.kolivas.org

Includes:
O(1) scheduler with batch scheduling
Preemptible
Low Latency
Read Latency2
Autoregulated VM
Variable Hz
Scheduler Tunables
Desktop Tuning
Supermount NG
XFS 1.2
ACPI
CPU Frequency Scaling
NForce2 update
Packet writing
GCC 3.3 fixes

Optional extras not included in full patch but available:
2.5 Interactivity update
Swap prefetching
Lowest Latency Disk Hack
AA VM addons
RMAP
Compressed Caching.

Changes:
Patch restructure to allow easy selection and applying of split out patches.
Major change is my VM hacks that are now the default. These use the default VM 
with changes based on the system and memory stress the kernel senses to 
create a VM that's cachier with free memory and aggressive at avoiding swap. 
It builds on the lean nature of the default VM without adding noticeable 
overhead. See my website for a lengthier description or the patch itself for 
documented code.
The desktop tuning is now 10/40 ms for min/max timeslice, and further tuning 
to avoid that nasty nasty i/o elevator pause problem. MCP and I are working 
hard on trying to find a useful fix since noone else is interested any more. 
See http://kernel.kolivas.org/elevator.html for more info.
Supermount has been revamped to the new supermount-ng code 
(http://supermount-ng.sf.net)
Nforce2 update and GCC3.3 fixes.
Optional:
I've implemented some simple (read braindead) but effective swap prefetching 
code which slowly trickles in pages from swap when the machine is idle and 
there is free ram.
For the most resistant cases of i/o induced pauses I have the nasty lowest 
latency disk hack I made which drops throughput significantly but will remove 
them entirely.
The AA VM addons are now optional instead of the default as I've moved to my 
VM addons, and will rip out my changes (as is the case with rmap).
Compressed caching adds to my VM addons instead of AA.

Feel free to send me queries, comments, suggestions, patches etc.

Regards,
Con Kolivas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+0bjWF6dfvkL3i1gRAqeMAJ9MnPdAn1wg94vi+V5MHl49SfyTMgCfYAiN
FO4NBqHV68whBUxOmcUyils=
=9+SU
-----END PGP SIGNATURE-----

