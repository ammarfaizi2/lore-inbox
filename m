Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269149AbTB0Bbe>; Wed, 26 Feb 2003 20:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269150AbTB0Bbe>; Wed, 26 Feb 2003 20:31:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16840 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269149AbTB0Bba>; Wed, 26 Feb 2003 20:31:30 -0500
Date: Wed, 26 Feb 2003 17:41:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 415] New: aty128fb.c fails to compile (logic error)
Message-ID: <13740000.1046310106@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=415

           Summary: aty128fb.c fails to compile (logic error)
    Kernel Version: 2.5.63
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: donaldlf@i-55.com


Distribution:rawhide
Hardware Environment: LX164/alpha
Software Environment: redhat
Problem Description:

the driver aty128fb.c aka DRI for ATI Rage pro fails to compile
due to logic error in aty128fb_setup there are 3 #define cases each
is for mac, intel , or ppc. there is an 4th case for default purposes.
The logic is constructed so that it's an if else logic tree, find a good
 case short circuit around the rest. The problem is if one of the three
conditions don't apply then there is an else with no if. I restructured
the code so now it uses continues. Same speed fewer indentions and 
it will now compile. 

patch will be include in followup.

Steps to reproduce:

select XFree 4.1 DRI modules.
select an non PPC no Intel hardware
select ATI Rage 128 DRI driver
compile.


