Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTDIP3w (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTDIP3w (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:29:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63621 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263519AbTDIP3v (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 11:29:51 -0400
Date: Wed, 9 Apr 2003 11:42:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ville Herva <vherva@niksula.hut.fi>
cc: Soeren Sonnenburg <kernel@nn7.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mounting partitions on loopback fs ?
In-Reply-To: <20030409153040.GT159052@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.53.0304091137500.30328@chaos>
References: <1049880018.2764.46.camel@fortknox> <20030409153040.GT159052@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003, Ville Herva wrote:

> On Wed, Apr 09, 2003 at 11:20:22AM +0200, you [Soeren Sonnenburg] wrote:
> > Hi!
> >
> > I dd'ed a whole harddisk into a file and set it up using losetup...
> >
> > when I fdisk /dev/loop0 I can clearly see all the partitions. However I
> > have no idea how I could mount them. Is that possible / what needs to be
> > tweaked to make that possible ?
>

mount -o loop filename /mountpoint

Here is an example:

Script started on Wed Apr  9 11:39:27 2003
# ls -la
total 370560
drwxr-xr-x   2 root     root         4096 Apr  9 11:39 .
drwxr-xr-x  63 root     root         4096 Apr  9 11:39 ..
-rwxr-xr-x   1 root     root          212 Sep 27  2002 cp-win.sh
-rw-r--r--   1 root     root            0 Apr  9 11:39 typescript
-rwxr-x--x   1 root     root     379064320 Jan 25  2002 win.raw
# mount -o loop win.raw /mnt
# ls /mnt
autorun.inf  cdrom_ip.5  discover  read1st.txt	setup.exe  support
bootdisk     cdrom_nt.5  i386	   readme.doc	setuptxt   valueadd
# exit
exit
Script done on Wed Apr  9 11:40:07 2003

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

