Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTDVRd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDVRd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:33:56 -0400
Received: from [63.246.199.14] ([63.246.199.14]:41857 "EHLO ns.briggsmedia.com")
	by vger.kernel.org with ESMTP id S263285AbTDVRdy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:33:54 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: motion@pdx.frogtown.com, linux-kernel@vger.kernel.org
Subject: IDE corruption during heavy bt878-induced interrupt load
Date: Tue, 22 Apr 2003 14:45:14 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304221445.14656.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeking comments or suggestions to this problem:

I create multi-channel digital surveillance systems using cards with 4 or more 
multiplexed bt878 framegrabbers; each one capturing 5 or more frames per 
second on each of its two input channels (total 4 * 2 * 5 = 40 fps).  
Typically I run using either a Promise or Adaptec HPT370 IDE-RAID controller 
with 2 WD-120GB/8MB-cache drives striped in RAID-0, with another IDE as hda 
for my system drive.  What happens is that every few seconds I get a "BTTV: 
RISC ERROR - resetting" from the frame grabber driver.  After a few days of 
this I have corruption on my Reiser file system; which usually I am able to 
clean up with mkreiserfs --fix-fixable or --rebuild-tree.  The corruption is 
both on my RAID and my system drive.  Missing doing this maintenance action 
can really ruin my day.

I am today replacing the IDE RAID with a 3WARE IDE-RAID that emulates SCSI on 
the premise that the problem has to do with hardware bus arbitration.  But as 
of yet I don't have any data to support that or show improvement.


All comments/suggestions/etc. appreciated.

Joe


-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL/FAX 603-232-3115 MOBILE 603-493-2386
www.briggsmedia.com
