Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTAGXQO>; Tue, 7 Jan 2003 18:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267588AbTAGXQO>; Tue, 7 Jan 2003 18:16:14 -0500
Received: from smtp4.us.dell.com ([143.166.148.135]:25816 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S267583AbTAGXQN>; Tue, 7 Jan 2003 18:16:13 -0500
Date: Tue, 7 Jan 2003 17:24:51 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EDD: fix raw_data file and edd_has_edd30(), misc cleanups
Message-ID: <Pine.LNX.4.44.0301071723020.3361-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd

This will update the following files:

 arch/i386/kernel/edd.c |  252 +++++++++++++++++++++++--------------------------
 1 files changed, 120 insertions, 132 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (03/01/07 1.890)
   EDD: fix raw_data file and edd_has_edd30(), misc cleanups
   
   * Update copyright date
   * s/driverfs/sysfs in comments
   * bump version
   * bug fix: raw_data file was always printing device 0's info.
   * bug fix: edd_has_edd30 was always returning device 0's info.
   * always print the report info at the end of raw_data
   * edd_dev_is_type() should return boolean
   * edd_match_scsidev() should return boolean
   * remove duplicate calls to pci_find_slot, use edd_get_pci_dev().
   * attribute tests should return boolean
   * add edd_release()
   * work if !CONFIG_SCSI=[ym]
   * use new find_bus() and bus_for_each_dev() to match SCSI devices

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


