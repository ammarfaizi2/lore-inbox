Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWCNDSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWCNDSV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWCNDSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:18:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:27530
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932494AbWCNDSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:18:21 -0500
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: How do I get the ext3 driver to shut up?
Date: Mon, 13 Mar 2006 22:18:39 -0500
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603132218.39511.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm making a test suite for busybox mount, which does filesystem autodetection 
the easy way (try all the ones in /etc/filesystems and /proc/filesystems 
until one of them succeeds).  My test code is creating and mounting vfat and 
ext2 filesystems.

Guess which device driver feels a bit chatty?

PASS: mount no proc [GNUFAIL]
PASS: mount /proc
PASS: mount list1
VFS: Can't find ext3 filesystem on dev loop0.
PASS: mount vfat image (autodetect type)
ext3: No journal on filesystem on loop1
PASS: mount ext2 image (autodetect type)
PASS: mount remount ext2 image noatime
PASS: mount remount ext2 image ro remembers noatime
ext3: No journal on filesystem on loop0
PASS: umount freed loop device
PASS: mount remount nonexistent directory
PASS: mount -a no fstab

Rob
-- 
Never bet against the cheap plastic solution.
