Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129242AbRCPAeq>; Thu, 15 Mar 2001 19:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbRCPAeg>; Thu, 15 Mar 2001 19:34:36 -0500
Received: from isc4.tn.cornell.edu ([128.84.242.21]:31409 "EHLO
	isc4.tn.cornell.edu") by vger.kernel.org with ESMTP
	id <S129242AbRCPAed>; Thu, 15 Mar 2001 19:34:33 -0500
Date: Thu, 15 Mar 2001 19:33:24 -0500 (EST)
From: "Donald J. Barry" <don@astro.cornell.edu>
Message-Id: <200103160033.TAA09549@isc4.tn.cornell.edu>
To: linux-kernel@vger.kernel.org
Subject: Write throttling problem in 2.4.2?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Developers:

More on my 2.4.2 oopses concerning the "Unable to handle kernel paging
request"

These only take place during ENORMOUS write pressure, and I'm curious
as to whether write throttling is an issue here.  Since this is on 
a reiserfs atop lvm, some of the previously conceived solutions 
may not apply.  

It's not a major problem, as it only occurs I can start a tars transferring 
tens of gigabytes.  But if I also then launch a task doing enormous activity 
on the vfs, such as a simultaneous "du -s ." on the directories in 
question, I can pretty reliably create the kernel paging fault.

Cheers,

Don Barry
Cornell Astronomy

-- 2.4.2 vanilla kernel + Brown's NFS patches, pretty minimal otherwise
-- problem first seen on 256M ram, still persists at 392M ram
-- LVM atop hda/hdb (60g) (motherboard via kt133 chipset) plus promise ultra66
   controller driving 80 gig drive on hde





