Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWH2Mxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWH2Mxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWH2Mxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:53:37 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:15297 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932305AbWH2Mxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:53:36 -0400
Date: Tue, 29 Aug 2006 14:53:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Drop cache has no effect?
Message-ID: <Pine.LNX.4.61.0608291449060.10486@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


recently I picked up knowledge of /proc/sys/vm/drop_caches 
(http://lkml.org/lkml/2006/8/4/95)

It does not always work right away:

(/U is a vfat, that is, permissions are back to 755 as soon as the caches 
are gone)
14:51 gwdg-wb04A:/U # chmod 644 *
14:51 gwdg-wb04A:/U # sync
14:51 gwdg-wb04A:/U # echo 2 >/proc/sys/vm/drop_caches 
14:51 gwdg-wb04A:/U # l
total 50713
drwxr-xr-x   3 jengelh users     2048 2006-08-29 14:48 .
drwxr-xr-x  22 root    root      4096 2006-08-25 14:00 ..
drw-r--r--   2 jengelh users     2048 2006-08-29 13:55 as
-rw-r--r--   1 jengelh users 13806629 2006-08-29 14:00 all-20060611.tar.bz2
-rw-r--r--   1 jengelh users 37816633 2006-07-28 19:25 
inkscape-0.44-2.guru.suse101.i686.rpm
-rw-r--r--   1 jengelh users   297243 2006-08-15 01:13 
vmware-any-any-update104.tar.gz

Remains 644.



Jan Engelhardt
-- 
