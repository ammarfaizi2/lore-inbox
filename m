Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWB0PLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWB0PLE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 10:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWB0PLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 10:11:03 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:44707 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751389AbWB0PLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 10:11:02 -0500
To: fuse-devel@lists.sourceforge.net,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Announce] mountlo 0.5 - Loopback mounting in userspace
Message-Id: <E1FDk1G-0004S6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 Feb 2006 16:10:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm proud to announce a new version of my pet project 'mountlo', a
utility which works similarly to 'mount -o loop', but the filesystem
runs entirely in userspace.

While arguably it is quite useless, I like it because it combines some
of my favorite technologies (Linux, UML and FUSE) with very little
additional glue code.

Features:

 o safe mounting of filesystem images for unprivileged users
 o all disk-filesystem types supported in a single binary

What's new since 0.2:

 o support for partitioned disk images
 o support for mount options
 o error reporting both from mount and the kernel
 o achieves reasonable performance using SKAS0 mode of UML
 o verbose and debug modes

An i386 binary (2MB) is available at:

  http://prdownloads.sourceforge.net/fuse/mountlo-i386-0.5.tar.gz

Requirements for running the binary are:

  - FUSE kernel module.  Since 2.6.14, this is included in mainline
  - FUSE utilities (at least version 2.2).

Compiling from source needs the following components:

   - http://prdownloads.sourceforge.net/fuse/mountlo-0.5.tar.gz
   - Linux-2.6.15 kernel source
   - FUSE-2.5 or later devel package (or source installation)

Comments and bug reports are welcome.

Miklos
