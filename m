Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVCVQo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVCVQo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVCVQo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:44:58 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:42986 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261423AbVCVQou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:44:50 -0500
From: Paul Slootman <paul+nospam@wurtel.net>
Subject: md: bug in file drivers/md/md.c, line 1513
Date: Tue, 22 Mar 2005 16:44:49 +0000 (UTC)
Organization: Wurtelization
Message-ID: <d1pi21$gjq$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1111509889 17018 83.68.3.130 (22 Mar 2005 16:44:49 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is on kernel 2.6.11, mdadm 1.4.0

The system has MD devices that are auto-configured on boot.

However, there are also devices connected via another SCSI adapter
(actually, a Qlogic QLA2300). I'm using a module for that. As the
auto-configure only runs at boot (or rather, when the md subsystem is
started).  I wanted to restart a raid-0 device that I had previously
created. I did:

	mdadm --run /dev/md10

as a simple attempt to see what would happen. What happened was the
error message in the subject, and a "COMPLETE RAID STATE PRINTOUT"...
In that output there is a line "md10:", the next line is
"md1: <sde1><sdd1><sdc1><sdb1><sda1>".


Admittedly the usage may be wrong, but having the kernel say "bug" can't
be right :-)


Paul Slootman

