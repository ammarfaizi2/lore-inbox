Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318149AbSGWQjI>; Tue, 23 Jul 2002 12:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318147AbSGWQjI>; Tue, 23 Jul 2002 12:39:08 -0400
Received: from [216.167.57.166] ([216.167.57.166]:32010 "EHLO
	liveglobalbid.com") by vger.kernel.org with ESMTP
	id <S318146AbSGWQjG>; Tue, 23 Jul 2002 12:39:06 -0400
Message-ID: <3D3D8768.851E14A6@liveglobalbid.com>
Date: Tue, 23 Jul 2002 10:42:16 -0600
From: Roe Peterson <roe@liveglobalbid.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: 2.5.27 RAID1 not shutting down at halt/reboot???
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux 2.5.27 running over a redhat 7.3 distro...

I've got the raid1/md stuff working correctly, but the system doesn't
shut
down the raid arrays at reboot/halt/poweroff...

A quick look at the md_notify_reboot code in drivers/md.c line 3174
reveals:

    printk(KERN_INFO "md: stopping all md devices.\n");
    return NOTIFY_DONE;

!!! followed by the md array shutdown code, which is obviously never
called.

Is there a reason for this?  Should _something_else_ be shutting down
/read-only switching the raid arrays at system halt?



