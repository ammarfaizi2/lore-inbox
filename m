Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTDUPiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDUPiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:38:08 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49089 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261390AbTDUPiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:38:05 -0400
Date: Mon, 21 Apr 2003 08:50:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 612] New: aic7<CENSORED> driver hang 
Message-ID: <29320000.1050940208@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=612

           Summary: aic7xxx driver hang
    Kernel Version: 2.5.68
            Status: NEW
          Severity: high
             Owner: andmike@us.ibm.com
         Submitter: m4341@abc.se


Notes:
  1. Problem seems to be similar to bug #36.

Distribution:
  Red Hat 8.0 with kernel 2.5.68

Hardware Environment:
  HP Vectra XU 2*200MHz Pentium Pro
  scsi0: aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
    sda: SEAGATE   Model: ST39140N          Rev: 1498
      sda1: ext3 filesystem /boot       128M
      sda2: ext3 filesystem /           861M
  scsi1: aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
    sdb: SEAGATE   Model: ST318436LW
      sdb1: swap                          1G
      sdb2: ext3 filesystem /usr/local   16G
  ide-bus0: hda: DVD-ROM
  ide-bus1: hdc: CD-RW

Software Environment:
Problem Description:
  System "hangs" with logging of messages:
    "Attempting to queue an ABORT message"
  Only resort is to reset the machine.

Steps to reproduce:
  Problem seems to occur during high load on concurrent disk I/O when
running in
multi-processor mode. The problem does not occur if system is booted with a
single-processor kernel (SMP disabled in kernel build).


