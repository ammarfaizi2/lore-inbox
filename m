Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUDMAAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 20:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUDMAAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 20:00:14 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:63427 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263178AbUDMAAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 20:00:00 -0400
Subject: [BK PATCH] SCSI merge for 2.6.5
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Apr 2004 18:59:54 -0500
Message-Id: <1081814396.2234.67.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This represents all the queued updates since 2.6.4 went -rc.

It's mainly a round of updates, improvements and transport class
conversions.  The real big item is the qlogic updates, which include a
massive firmware revision.

The patch is available at

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

And the short changelog is:

Andrew Morton:
  o stack reduction: aic7xxx_old
  o Fix scsi_transport_spi.c for gcc-2.95.3

Andrew Vasquez:
  o [15/15] qla2xxx: Update driver version
  o [13/15] qla2xxx: Device reset fix
  o [12/15] qla2xxx: Restore update state during resync
  o [11/15] qla2xxx: Add login-retry-count override
  o [10/15] qla2xxx: Use fcports list for targets
  o [9/15] qla2xxx:  NVRAM id-list updates
  o [8/15] qla2xxx:  Use proper HA references
  o [7/15] qla2xxx:  Misc. updates with FO resync
  o [6/15] qla2xxx:  Track error-state of SBRs
  o RE: PATCH [5/15] qla2xxx:  request entries update
  o [4/15] qla2xxx:  Endianess fix while reading stats
  o [3/15] qla2xxx:  Increase MBX IOXB timeout
  o [2/15] qla2xxx:  Track DSDs used by an SRB
  o [1/15] qla2xxx:  Update copyright banner

Dave Jones:
  o USB multi-card reader blacklist updates

James Bottomley:
  o Convert sr to a kref and fix sr_open/sr_remove race
  o Convert sd to kref and fix sd_open/sd_remove race
  o SCSI: make DV check device capabilities
  o Add missing header changes from SCSI cdrom disconnection fix
  o Fix SCSI cdrom disconnection race
  o Fix scsi_device_get to allow NULL devices
  o sd_shutdown cannot be called when in state SDEV_DEL
  o SCSI: Updates to non-sector size completion calculations
  o SCSI: Add noretry check to the error handler path
  o ServeRAID ( ips ) 7.00.15
  o MPT Fusion driver 3.01.03 update
  o More domain validation fixes and additions
  o SCSI: correct blacklist entry
  o Fix error handler offline behaviour
  o [14/15] qla2xxx: 23xx/63xx firmware updates

Kurt Garloff:
  o SCSI sense buffer size -> 96

Mark Haverkamp:
  o aacraid reset handler update

Martin Hicks:
  o Fix template size calculation in transport attributes
  o Add FC transport attributes support to qla2xxx
  o Update FC transport attributes API

Matthew Wilcox:
  o sym 2.1.18j

Patrick Mansfield:
  o Add 192 byte MODE SENSE flag
  o Replace scsi_host flags with scsi_device sdev_bflags

James


