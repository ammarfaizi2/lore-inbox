Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUAJUmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbUAJUmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:42:11 -0500
Received: from inventor.gentoo.org ([216.223.235.2]:46464 "EHLO ht.gentoo.org")
	by vger.kernel.org with ESMTP id S265354AbUAJUmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:42:08 -0500
Subject: 2.6.0+ and loopback ext2
From: Daniel Robbins <drobbins@gentoo.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Gentoo Technologies, Inc.
Message-Id: <1073767356.7513.60.camel@music.gentoo.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 13:42:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm having a very strange problem with loopback under 2.6. I can create
a loopback ext2 filesystem, mount it, and then trying to copy files to
it. Sometimes, I'll get a "no space left on device" error. Then I'll try
the exact same copy again, and it will work. The copy seems to fail
randomly, about 25% of the time. I can repeat the copy operation and
have it fail, then work, then work. I can repeat everything and have it
work, then fail, then work again.

The filesystem is created using the following command:

mke2fs -m 0 -F -b 4096 -q my.loop

And is mounted using the following command:

mount -t ext2 -o loop my.loop loopmount

This is on an amd64 system; haven't tried replicating this on an x86 yet
(though my understanding is that loopback implementation is effectively
arch-independent?) Could this be the fault of util-linux's "/bin/mount"
command not containing a magic 2.6 hook for loopback? Tried rebuilding
util-linux, and it didn't help.

Any help would be welcome.

Best Regards,

Daniel Robbins

