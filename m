Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTBPQEG>; Sun, 16 Feb 2003 11:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTBPQEG>; Sun, 16 Feb 2003 11:04:06 -0500
Received: from franka.aracnet.com ([216.99.193.44]:64902 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267158AbTBPQEE>; Sun, 16 Feb 2003 11:04:04 -0500
Date: Sun, 16 Feb 2003 08:13:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 366] New: ieee1394 fails to compile  linux/drivers/ieee1394/dma.c
Message-ID: <15760000.1045412035@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=366

           Summary: ieee1394 fails to compile  linux/drivers/ieee1394/dma.c
    Kernel Version: 2.5.60
            Status: NEW
          Severity: high
             Owner: bcollins@debian.org
         Submitter: donaldlf@i-55.com


Distribution: redhat/rawhide
Hardware Environment: LX164
Software Environment: rawhide
Problem Description:

firewire codes fails to compile. Someone forget to include the correct header file.

Steps to reproduce:

attempt to compile

Fix:

*** linux/drivers/ieee1394/dma.c.orig   2003-02-15 23:34:00.000000000 -0800
--- linux/drivers/ieee1394/dma.c        2003-02-15 23:36:32.000000000 -0800
***************
*** 10,15 ****
--- 10,16 ----
  #include <linux/module.h>
  #include <linux/vmalloc.h>
  #include <linux/slab.h>
+ #include <linux/mm.h>
  #include "dma.h"
  
  /* dma_prog_region */


