Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUITLQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUITLQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUITLQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:16:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4008 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266291AbUITLQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:16:28 -0400
Date: Mon, 20 Sep 2004 13:16:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Olaf Hering <olh@suse.de>
cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
In-Reply-To: <20040920105618.GB24928@suse.de>
Message-ID: <Pine.LNX.4.61.0409201311050.3460@scrub.home>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de>
 <Pine.LNX.4.61.0409201220200.3460@scrub.home> <20040920105618.GB24928@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Sep 2004, Olaf Hering wrote:

> > How do you distinguish between manual and automatic loop device setup?
> 
> -v

???

> > How do you filter /proc/mounts for chroot environments?
> 
> you have a chroot enviroment without /proc mounted?
> Then just create /proc/mounts?

$ cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/hda5 /boot ext2 rw 0 0
/dev/hda11 /home ext3 rw 0 0
/dev/hda12 /test ext3 rw 0 0
none /test/proc proc rw 0 0
/dev/hda11 /test/home ext3 rw 0 0
/dev/hda6 / ext3 rw 0 0
none /proc proc rw 0 0
/dev/hda11 /home ext3 rw 0 0
$ mount
/dev/hda6 on / type ext3 (rw)
proc on /proc type proc (rw)
/dev/hda11 on /home type ext3 (rw)
$ ln -sf /proc/mounts /etc/mtab
$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
rootfs                 2480352   1222760   1232392  50% /
/dev/root              2480352   1222760   1232392  50% /
df: `/dev/pts': No such file or directory
/dev/hda5              2480352   1222760   1232392  50% /boot
/dev/hda11            15874464  14187420   1647044  90% /home
df: `/test': No such file or directory
df: `/test/proc': No such file or directory
df: `/test/home': No such file or directory
/dev/hda6              2480352   1222760   1232392  50% /
/dev/hda11            15874464  14187420   1647044  90% /home

bye, Roman
