Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbTEMWUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTEMWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:20:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:27890 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263713AbTEMWSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:18:52 -0400
Date: Tue, 13 May 2003 15:27:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm4 fails to boot
Message-Id: <20030513152713.217aac7a.akpm@digeo.com>
In-Reply-To: <20030513221435.GI32128@ca-server1.us.oracle.com>
References: <20030513221435.GI32128@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 22:31:34.0265 (UTC) FILETIME=[68A51690:01C3199F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> 	2.5.69-mm4 is failing to boot.  It completes init_rootfs() in
> mnt_init() but does not complete init_mount_tree().  Call me dumb, but
> nothing obvious jumps out at me, I don't see any diff(1) from -mm3, and
> I don't really have time to actively debug it.  I can indeed build and
> try kernels.

Could be a device driver or IO scheduler problem.  You may find that it's
stuck waiting for a disk read to complete.

Try using a different IO scheduler?

Does sysrq-T work?

What device driver does an ML570 use?

Please share your .config.
