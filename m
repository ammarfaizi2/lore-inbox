Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVGMUoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVGMUoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVGMUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:39:23 -0400
Received: from quechua.inka.de ([193.197.184.2]:21993 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262794AbVGMUiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:38:10 -0400
From: "Andreas Jellinghaus [c]" <aj@dungeon.inka.de>
Subject: Re: initramfs [u]
To: linux-kernel@vger.kernel.org
Mail-Copies-To: aj@dungeon.inka.de
Date: Wed, 13 Jul 2005 22:38:26 +0200
References: <200507131206.44537.vacant2005@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20050713203801.57A4E20E93@dungeon.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Jab?o?ski wrote:
> Do You know any tool to create initramfs (not initrd)?

that is very easy:
create a directory tree with everything you want in it
(for example ld.so, a libc, some applications and
config files and scripts and device files and whatever)
and then use cpio to pack the files and directories
into a cpio archive. gzip if you want.

cpio has several formats, be sure to choose the right
one. more information in 

Documentation/early-userspace/*

btw: most people want initrd/initramfs etc. with some
small libc (klibc, dietlibc etc.). But normal libcs
works very fine as well. I have some initramfs that
are build from a few dozend debian packages. the result
is a few hundred mb big (uncompressed), but that is ok
as I can load and boot it via network and it works
great and has all the normal linux tools in it.

also see the klibc mailing list, there have been several
discussions about initramfs and I posted example code
there I think. so look at the archives, too.

Regards, Andreas
