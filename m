Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270244AbTGMQB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTGMQB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:01:56 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:59294 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S270244AbTGMQBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:01:54 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.75 and xfs quotas 
Date: Sun, 13 Jul 2003 10:25:56 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131025.56438.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps I'm missing something silly, but with both generic quota v2 and xfs 
quota enabled (and xfs) all compiled into the kernel:
===========================================================
[root@cobra linux]# mount -o remount /dev/hda8

strace:
mount("/dev/hda8", "/", "xfs", MS_REMOUNT|0xc0ed0000, 0x805be00) = 0
===========================================================
[root@cobra linux]# mount -o remount,quota /dev/hda8
mount: / not mounted already, or bad option        

strace:                                                                                                                          
mount("/dev/hda8", "/", "xfs", MS_REMOUNT|0xc0ed0000, 0x805be38) = -1 EINVAL 
(Invalid argument)
===========================================================








