Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270659AbRHJWBS>; Fri, 10 Aug 2001 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270660AbRHJWBG>; Fri, 10 Aug 2001 18:01:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37380 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270656AbRHJWA4>; Fri, 10 Aug 2001 18:00:56 -0400
Subject: Re: [PATCH] LVM snapshot support for reiserfs and others
To: akpm@zip.com.au (Andrew Morton)
Date: Fri, 10 Aug 2001 23:01:39 +0100 (BST)
Cc: mason@suse.com (Chris Mason), viro@math.psu.edu (Alexander Viro),
        adilger@turbolinux.com (Andreas Dilger), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, lvm-devel@sistina.com,
        ext3-users@redhat.com (ext3-users@redhat.com)
In-Reply-To: <no.id> from "Andrew Morton" at Aug 10, 2001 01:04:27 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VKLb-0001i5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ext3 will probably lock up on unmount with 2.4.8-pre8.  The fix is
> to replace fsync_dev with fsync_no_super in fs/ext3/super.c and
> fs/jbd/recovery.c.  I'll be generating a new patchset this weekend.

Actually if you dont fix recovery.c it will hang the machine when you mount
an fs that needs recovering. With the old patches at least umount of ext3
seems fine as is.

Alan
