Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbUBXVoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUBXVoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:44:07 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:3999 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S262482AbUBXVmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:42:53 -0500
Subject: Re: /proc/mounts "stuff"
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0402241630500.4054@chaos>
References: <Pine.LNX.4.53.0402241630500.4054@chaos>
Content-Type: text/plain
Message-Id: <1077658970.7783.62.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 16:42:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 16:34, Richard B. Johnson wrote:
> Linux version 2.2.24 (actually since pivot-root), have a
> problem with what's in /proc/mounts vs. what's written
> to /etc/mtab when mounting file-systems.

[file contents snipped]

> On that system /dev/root doesn't even exist!
> Neither does rootfs in any accessible way. Therefore,
> the shutdown routine(s) that read /proc/mounts will
> fail, leaving improperly dismounted volumes.  Basically,
> if I execute `init 0` from the console, everything's
> fine, but executing 'reboot' from a network connection
> will result in a long fsucking startup.
> 
> I think the two unusable entries should not show in
> /proc/mounts,
> 	rootfs / rootfs rw 0 0
> 	/dev/root / ext2 rw 0 0
> That would fix the problem because there is no way to
> umount either of them. Try it, `umount rootfs` returns
> ENOENT as does `umount /dev/root'`.

I have been considering making this same post for a while.

I do have a /dev/root (a symlink to my actual root device), and it is no
better.  At shutdown/reboot time rootfs is still tried to be umounted
and fails leaving me with a dirty root at the next boot.


-- 
Chris

