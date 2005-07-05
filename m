Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261843AbVGEQ3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVGEQ3Z (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 5 Jul 2005 12:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVGEQ0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 12:26:02 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:6568 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S261843AbVGEQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 12:11:08 -0400
Date: Tue, 5 Jul 2005 11:08:15 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: Online resizing devices
Message-ID: <20050705160815.GA14324@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to do an online resize of and XFS filesystem on a non-partitioned
device.  But, I always have to reboot to do so.

Say I have a sdc with 16777216 blocks and expand it on the SAN
to have 17825792 blocks, and rescan the device.

The xfs_growfs does not see the size, nor does blockdev --getsz /dev/sdc,
however, the I know the rescan worked because /sys/block/sdc/size now is
17825792 instead of 16777216.

Is there some reason for this?  Is there a fix for it?  I'm not using any
volume management stuff yet but would like to be able to grow our
filesystems without having to reboot to do so.

Andy 
