Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281870AbRK1EqW>; Tue, 27 Nov 2001 23:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281883AbRK1Ep7>; Tue, 27 Nov 2001 23:45:59 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:10913 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S281870AbRK1Epu>; Tue, 27 Nov 2001 23:45:50 -0500
Date: Tue, 27 Nov 2001 23:48:43 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre2 elvtune: ioctl get: Inappropriate ioctl for device
Message-ID: <20011127234843.A6398@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a kernel in transition thing, or perhaps
a util-linux has to change.

In 2.5.1-pre2:

/usr/src# elvtune /dev/hda
ioctl get: Inappropriate ioctl for device

/usr/src# nm linux-2.5.1-pre1/vmlinux|grep elv.*ioctl
c0187400 T blkelvget_ioctl
c01874b0 T blkelvset_ioctl

/usr/src# nm linux-2.5.1-pre2/vmlinux|grep elv.*ioctl
/usr/src# 

Recompiling util-linux-2.11m with or without the new elevator.h
doesn't change elvtune's output.

..

2.5.1-pre2 passes 11 Linux Test Project "personality" tests 
that are broken in 2.5.1-pre1 and 2.4.16. 

-- 
Randy Hron

