Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbTGTVXH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268495AbTGTVXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:23:07 -0400
Received: from rrcs-west-24-24-160-174.biz.rr.com ([24.24.160.174]:34233 "EHLO
	pacserv.unco.de") by vger.kernel.org with ESMTP id S268453AbTGTVXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:23:04 -0400
Date: Sun, 20 Jul 2003 14:38:03 -0700
From: Hielke Christian Braun <hcb@unco.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 cryptoloop & aes & xfs
Message-ID: <20030720213803.GA777@jolla>
References: <20030720005726.GA735@jolla> <20030720103852.A11298@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720103852.A11298@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the tip. With util-linux-2.12 i can setup the device.

So the new cryptoloop in 2.6.0 is incompatible to the one in the
international crypto patch? 

I could not access my old data. So i created a new one. But when 
i copy some data onto it, i get: 

XFS mounting filesystem loop5
Ending clean XFS mount for filesystem: loop5
xfs_force_shutdown(loop5,0x8) called from line 1070 of file fs/xfs/xfs_trans.c. Return address = 0xc02071ab
Filesystem "loop5": Corruption of in-memory data detected. Shutting down filesystem: loop5
Please umount the filesystem, and rectify the problem(s)
 
To setup, i did this:

losetup -e aes /dev/loop5 /dev/hda4
mkfs.xfs /dev/hda4

Regards,
 Christian.

