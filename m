Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUFQSjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUFQSjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 14:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUFQSjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 14:39:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2824 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261682AbUFQSgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 14:36:06 -0400
Date: Thu, 17 Jun 2004 11:01:41 -0700
Message-Id: <200406171801.i5HI1fgo016484@fire-2.osdl.org>
From: bugme-daemon@osdl.org
To: rmk@arm.linux.org.uk
Subject: [Bug 2906] New: PCMCIA IDE device appears twice
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Category: Drivers
X-Bugzilla-Component: PCMCIA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2906

           Summary: PCMCIA IDE device appears twice
    Kernel Version: 2.6.6, 2.6.7
            Status: NEW
          Severity: normal
             Owner: rmk@arm.linux.org.uk
         Submitter: hadmut@danisch.de


Distribution: Debian
Hardware Environment: Dell Inspiron 3800
Software Environment:
Problem Description:

When I insert a CompactFlash-PCMCIA adapter
with a CompactFlash card, two harddisk
devices appear:

- the hotplug systems registers
  /block/hde and /block/hde1

- the cardmgr then executes
  ./ide start hde

- the hotplug system then registers
  /block/hdf and /block/hdf1


hde, hde1, hdf and hdf1 appear in the devfs:

apollo# ls -lF /dev/hd[ef]*
lr-xr-xr-x    1 root     root           32 2004-06-17 19:55 /dev/hde ->
ide/host2/bus0/target0/lun0/disc
lr-xr-xr-x    1 root     root           33 2004-06-17 19:55 /dev/hde1 ->
ide/host2/bus0/target0/lun0/part1
lr-xr-xr-x    1 root     root           32 2004-06-17 19:55 /dev/hdf ->
ide/host2/bus0/target1/lun0/disc
lr-xr-xr-x    1 root     root           33 2004-06-17 19:55 /dev/hdf1 ->
ide/host2/bus0/target1/lun0/part1


apollo# ls -lF /sys/block/hd[ef]/device
lrwxrwxrwx    1 root     root           22 2004-06-17 19:55
/sys/block/hde/device -> ../../devices/ide2/2.0/
lrwxrwxrwx    1 root     root           22 2004-06-17 19:55
/sys/block/hdf/device -> ../../devices/ide2/2.1/




regards
Hadmut

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
