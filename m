Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265595AbSKFF3O>; Wed, 6 Nov 2002 00:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265596AbSKFF3O>; Wed, 6 Nov 2002 00:29:14 -0500
Received: from zok.SGI.COM ([204.94.215.101]:20633 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S265595AbSKFF3N>;
	Wed, 6 Nov 2002 00:29:13 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-rc1 dirty ext2 mount error
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Nov 2002 16:35:40 +1100
Message-ID: <21293.1036560940@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The root partition was originally ext3.  fstab now contains

/dev/sda1               /                       ext2    defaults        1 1

Booting 2.4.20-rc1 (ext3 as a module, not loaded yet) with a dirty / gets

EXT2-fs: sd(8,1): couldn't mount because of unsupported optional features (4).
Drop back to 2.4.18 and it works, automatically running fsck.ext2 -a /dev/sda1.

