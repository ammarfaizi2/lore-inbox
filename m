Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWDGSbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWDGSbI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWDGSbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:31:08 -0400
Received: from gherkin.frus.com ([192.158.254.49]:56593 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S964849AbWDGSbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:31:06 -0400
Subject: [BUG] 2.6.17-rc1: SCSI kobject_add problems
To: linux-kernel@vger.kernel.org
Date: Fri, 7 Apr 2006 13:31:05 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060407183105.E6A38DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is a DEC Alpha 433au with two SCSI disks.  SCSI controller is a
QLA1040 supported by the qla1280 driver.  Runs 2.6.16 fine.  Tried
booting 2.6.17-rc1 and got

kobject_add failed for 0:0: with -EEXIST, don't try to register things with the same name in the same directory

and a fairly long trace output when the system attempted to add sdb.
Not surprisingly, sdb was inaccessible.

Normally (for 2.6.16 anyway), the following relationship exists:

sd 0:0:0:0	sda
sd 0:0:1:0	sdb

More information *might* be available if needed, but will have to be
transcribed by hand.  My /usr partition is on sdb, so I don't get very
far with 2.6.17-rc1 on Alpha :-).  The problem is probably specific to
the qla1280 or the Alpha, as I have a x86 Adaptec SCSI-based system
with multiple spindles that works fine with 2.6.17-rc1.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
