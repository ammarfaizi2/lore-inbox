Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311594AbSCXRfC>; Sun, 24 Mar 2002 12:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311597AbSCXRev>; Sun, 24 Mar 2002 12:34:51 -0500
Received: from adsl-64-109-89-110.dsl.chcgil.ameritech.net ([64.109.89.110]:18012
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S311594AbSCXRei>; Sun, 24 Mar 2002 12:34:38 -0500
Message-Id: <200203241734.g2OHYV810736@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
cc: James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.7] support for NCR voyager (3/4/5xxx 
 series)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Mar 2002 11:34:31 -0600
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This really only tidies up the split out of arch/i386 in the previous release. 
 It also backs out a fix for the migration_mask physical/logical CPU problems 
in 2.5.6 in favour of the official fix.

In response to will it work questions, this is the list of supported types

3430/3360 (Level 4): Works (tested up to 2 way), need sim710 driver for 
internal SCSI chip.
345x (Level 5): Works (tested up to 10 way), need NCR_D700 or BusLogic SCSI 
card.
35xx (Level 5): Should work up to 16 way (not tested), need NCR_D700 or 
BusLogic SCSI card.
4100 (Level 5): Should work (not tested), need NCR_D700 SCSI card.  Q720 
driver is broken currently, so must use D700 or BusLogic SCSI card.
51xx (Level 5): Should work up to 32 way (not tested).  No Q720 driver is a 
bit of a problem here since I don't think they support anything else.

The patch is in two parts this time:  The i386 sub-architecture split is 
separated from the addition of the voyager components

http://www.hansenpartnership.com/voyager/files/split-2.5.7.diff (259k)
http://www.hansenpartnership.com/voyager/files/split-2.5.7.BK (107k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.7.diff (149k)
http://www.hansenpartnership.com/voyager/files/voyager-2.5.7.BK (288k)

(The split diff is pretty huge because it's actually moving files about).  You 
must apply the split diff before applying the voyager one.

James Bottomley


