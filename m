Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTARQry>; Sat, 18 Jan 2003 11:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTARQry>; Sat, 18 Jan 2003 11:47:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17412 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264931AbTARQry>; Sat, 18 Jan 2003 11:47:54 -0500
To: LKML <linux-kernel@vger.kernel.org>
CC: Vojtech Pavlik <vojtech@suse.cz>
From: Russell King <rmk@arm.linux.org.uk>
Subject: 2.5.59: Input subsystem initialised really late
Message-Id: <E18ZwH5-0007ks-00@flint.arm.linux.org.uk>
Date: Sat, 18 Jan 2003 16:56:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to be impossible to get a SysRQ-T dump out of a kernel which
has hung during (eg) the SCSI initialisation with 2.5.

Unlike previous 2.4 kernels, the keyboard is no longer initialised until
fairly late - after many of the other drivers have initialised.
Unfortunately, this means that it is quite difficult to debug these hangs
(we'll leave discussion about in-kernel debuggers for another time!)

Can we initialise the input subsystem earlier (eg, after pci bus
initialisation, before disks etc) so that we do have the ability to use
the SysRQ features?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
