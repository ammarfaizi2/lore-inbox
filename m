Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWDSV6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDSV6S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWDSV6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:58:17 -0400
Received: from smtp.uaf.edu ([137.229.34.30]:16146 "EHLO smtp.uaf.edu")
	by vger.kernel.org with ESMTP id S1751266AbWDSV6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:58:16 -0400
From: Joshua Kugler <joshua.kugler@uaf.edu>
Organization: UAF Center for Distance Education - IT
To: linux-kernel@vger.kernel.org
Subject: Patch for removing 2TB RAID1 component limit (for pre 2.6.16)
Date: Wed, 19 Apr 2006 13:58:09 -0800
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191358.09551.joshua.kugler@uaf.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have googled, looked through release notes, and investigated everywhere I 
know to investigate, so I'm hoping this short note will find the help I need.

I am working on a Redhat-based system (CentOS) and would like to compile the 
kernel to support RAID1 components larger than 2TB (5.1TB in this case).  I 
know the 2TB limitation went away somewhere in 2.6.16, but I cannot find any 
reference to the patch or the change in the ChangeLogs.  Is it as simple as 
replacing everything in /md, or is there more involved?

I've tried experiment with 5.6 TB sparse files, but even on systems where I 
have 5.1TB raid components working, try to do this:

mdadm -C /dev/md10 --auto=yes -l raid1 -n2 sparsefile1 sparsefile2

returns:

mdadm: Cannot open sparsefile1: File too large
mdadm: Cannot open sparsefile2: File too large
mdadm: create aborted

So, I can't determine experimentally whether or not the patch has been 
included, nor whether or not a 5.1TB component would work.

So, any tips, pointers, or patches for the large MD devices?

Thanks!

j----- k-----

-- 
Joshua Kugler                 PGP Key: http://pgp.mit.edu/
CDE System Administrator             ID 0xDB26D7CE
http://distance.uaf.edu/
