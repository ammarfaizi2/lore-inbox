Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUE2TlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUE2TlA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 15:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUE2TlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 15:41:00 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:28910 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263603AbUE2Tk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 15:40:59 -0400
Date: Sat, 29 May 2004 15:35:34 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Steve Lord <lord@xfs.org>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       XFS List <linux-xfs@oss.sgi.com>
Subject: Re: xfs partition refuses to mount
In-Reply-To: <40B8D24A.4080703@xfs.org>
Message-ID: <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004, Steve Lord wrote:
>You have turned on XFS debug, which is really a developer option. It
>looks like you have a corrupt journal though. A non debug kernel may
>still refuse to mount it and you would need to run xfs_repair from
>a rescue disk in that case.

Unless xfs_repair has been changed recently, all it will be able to do it
delete (zero) the journal.  If it detects metadata in the journal, it'll
stop and tell you mount the filesystem to replay the journal.  Personally,
I think that's sorta stupid... if I could mount the fs, I wouldn't be
running xfs_repair. (I've had the journal become spooge on a sparc64
box a few times.)

There should be a way to instruct the kernel's rootfs mount to not look
at the log.  I don't know if one can pass any generic mount options at
boot. ("ro"/"rw" and rootfs type, but I don't know of any others.)  This
would be handy for more than just xfs, btw.

--Ricky


