Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261513AbTC3StL>; Sun, 30 Mar 2003 13:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbTC3StL>; Sun, 30 Mar 2003 13:49:11 -0500
Received: from franka.aracnet.com ([216.99.193.44]:33152 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261513AbTC3StK>; Sun, 30 Mar 2003 13:49:10 -0500
Date: Sun, 30 Mar 2003 11:00:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 521] New: cdrecord fails to see drive caps consistently when using ide-cd
Message-ID: <1830000.1049050828@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=521

           Summary: cdrecord fails to see drive caps consistently when using
                    ide-cd
    Kernel Version: 2.4.66-mm1
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: jeremy@goop.org


Distribution: Redhat-8.0 + some Rawhide additions
Hardware Environment: 1.8GHz P4, 1Gbyte ram, Plextor PX-W4824A CD-R
Software Environment: cdrecord 2.0 (Redhat Rawhide)
Problem Description:

When using "cdrecord dev=/dev/hdc -checkdrive" cdrecord fails to consistently
read the drive capabilities properly.  When it works, it should display:
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   :
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W4824A'
Revision       : '1.04'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R

When it fails, it displays:
Device type    : Removable CD-ROM
Version        : 0
Response Format: 1
Vendor_info    : 'PLEXTOR '
Identifikation : 'CD-R   PX-W4824A'
Revision       : '1.04'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC
Supported modes:

Notice that "version" and "response format" have changed.

Steps to reproduce:
cdrecord dev=/dev/hdc -checkdrive


