Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264368AbTCXRN3>; Mon, 24 Mar 2003 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264377AbTCXRNJ>; Mon, 24 Mar 2003 12:13:09 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16860 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264368AbTCXRLS>; Mon, 24 Mar 2003 12:11:18 -0500
Date: Mon, 24 Mar 2003 09:22:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 493] New: Support for Sony DSP-P72 not available 
Message-ID: <91700000.1048526544@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=493

           Summary: Support for Sony DSP-P72 not available
    Kernel Version: 2.4.20, 2.5.6x
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: milan@cmm.ki.si


Distribution:debian, gentoo
Hardware Environment:x86
Software Environment:GNU
Problem Description:There is no support for DSC-P72 digital camera in
drivers/usb/storage/unusual_devs.h for DSC-P72

Steps to reproduce:
add the following after similar DSC-S30 block to support also this camera:

UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0450, 
		"Sony",
		"DSC-P72", 
		US_SC_SCSI, US_PR_CB, NULL,
		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),


