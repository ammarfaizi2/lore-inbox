Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTL1Xnz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 18:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTL1Xnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 18:43:55 -0500
Received: from rocket.alienwebshop.com ([216.120.226.160]:32782 "EHLO
	rocket.alienwebshop.com") by vger.kernel.org with ESMTP
	id S262283AbTL1Xnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 18:43:53 -0500
Date: Sun, 28 Dec 2003 18:43:53 -0500 (EST)
From: Peter Leftwich <Hostmaster@Video2Video.Com>
X-X-Sender: pete@rocket.alienwebshop.com
To: debian-bsd@lists.debian.org, debian-user@lists.debian.org,
       owner-linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: mount from debian to 44bsd, chown bug report?
Message-ID: <20031228183005.G86605@rocket.alienwebshop.com>
Organization: Video2Video Services - http://Www.Video2Video.Com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.  I am booting up into a bootable Knoppix 3.2 (Debian Linux)
CD-R (www.knoppix.net) and trying to mount my FreeBSD 4.7-RELEASE partition.

The working command-line is:
`mount -t ufs -o ufstype=44bsd /dev/hda2 /mnt/fbsd`

At one time I was naturally able to read/write files to the partition once
it was mounted, but then I chowned the root directory to "knoppix."  Now
here is what's happening:

  # whoami ; mount | grep 44bsd
  root
  /dev/hda2 on /mnt/test type ufs (rw,ufstype=44bsd)

  # ls -al /mnt | grep knoppix
  drwxr-x--x   25 knoppix  root         1024 Dec 18 22:10 /mnt/test

  # grep ufs /proc/filesystems
  ufs

  # chown root /mnt/test
  chown: changing ownership of `test': Read-only file system

The error above contradicts the "mount" info, namely, the "rw" part!!

Is this a BUG?  Might a fix be to give the user "knoppix" the ability
to mount?  Please help me, someone...?

--
Peter Leftwich
President & Founder, Video2Video Services
Box 13692, La Jolla, CA, 92039 USA
http://Www.Video2Video.Com
