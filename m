Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVHOXZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVHOXZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVHOXZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:25:37 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:37577 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932569AbVHOXZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:25:36 -0400
From: Grant Coady <Grant.Coady@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.5 ATAPI Iomega Zip100 problem, more info, solved?
Date: Tue, 16 Aug 2005 09:25:22 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <jc72g114jnjlf8329afer716c8jr7e4b8h@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Some more info on removable media oddness.  I use both vfat and ext2 
format zip disk.  Two mountpoints:

/dev/hdc4       /mnt/zip        vfat            noauto,user             0 0
/dev/hdc1       /mnt/zip2       ext2            noauto,user             0 0

Odd behaviour:

$ mount /mnt/zip
mount: /dev/hdc4 is not a valid block device

Yet at this point fdisk can access the zip disk.  On the other hand an ext2 
formatted zip disk works as expected with "mount /mnt/zip2"


Making ide_floppy a module avoids this odd behaviour.

Cheers,
Grant.

