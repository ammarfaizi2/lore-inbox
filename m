Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271838AbTGRQej (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271835AbTGRQec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:34:32 -0400
Received: from franka.aracnet.com ([216.99.193.44]:60361 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271804AbTGRQcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:32:55 -0400
Date: Fri, 18 Jul 2003 09:47:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 956] New: Kernel hangs when using a primary and secondary IDE controller under software raid0
Message-ID: <10140000.1058546855@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=956

           Summary: Kernel hangs when using a primary and secondary IDE
                    controller under software raid0
    Kernel Version: 2.4.20-18.9 and 2.6.0-mm1-ac2
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: SpamBox@cableone.net


Distribution:RedHat 9.0
Hardware Environment:K7V motherboard with onboard ATA66 controller. Secondary 
controller is Promise PCD20268 - ATA100
Software Environment: 2.4.20-18.9 and 2.6.0-mm1-ac2
Problem Description: I'm attempting to use 3 HDs under software raid0. My 
Maxtor 40GB HD is attached 
to the ATA66 onboard controller on my K7V motherboard, and my two 20GB IBM HDs 
are attached to the secondary Promise controller (PDC20268 - ATA100).

If I create a raid0 configuration consisting only of my two IBM HDs everything 
is fine. When using all 3 HDs the kernel locks up so tightly that even 
Alt+SysRq+T does not respond.

All three HDs can be used in Linux provided they are not used in raid.

Tests were run using ext3 and ext2.

I have researched the problem for a couple weeks and the only work-around I 
have found is using ide=nodma which is not a very desirable solution.

I will be glad to add additional info if it is needed. Just let me know.


Steps to reproduce:
1. The problem should be reproducable by using a primary and secondary IDE 
controller under software raid0.
2.Run bonnie++


