Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVJNRl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVJNRl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVJNRl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 13:41:58 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:33421 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750815AbVJNRl6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 13:41:58 -0400
Date: Fri, 14 Oct 2005 13:41:45 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@rhla.com>
cc: linux-kernel@vger.kernel.org, moliveira@latinsourcetech.com
Subject: Re: Problems in kernel migration from 2.4 to 2.6
In-Reply-To: <434FBF3F.2040604@rhla.com>
Message-ID: <Pine.LNX.4.58.0510141336430.23643@localhost.localdomain>
References: <434FBF3F.2040604@rhla.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2005, Márcio Oliveira wrote:

> Hi there!
>
>   I am migrating my linux laptop from a kernel 2.4.27-2  to a 2.6.12.6
> one. Since I compiled the 2.6.12.6 kernel and booted my laptop, I am
> receiving the following message when chose the 2.6.12.6 entry in the
> grub menu:
>
> mount: mount point dev does not exist
> pivot_root: No such file or directory
> /sbin/init: 432: cannot open dev/console: No such file
> Kernel panic - not syncing: Attempted to kill init!
>
>    But when I chose the 2.4.27 entry in the grub meno, my laptop boots ok!
>
>    My laptop is running Debian Sarge 3.1a,  kernel 2.4.27-2 (that it is
> booting ok) and kernel 2.4.6.12.6 (kernel.org kernel).  I compiled the
> 2.6.12.6 kernel with all needed modules (sata disk, ext3 ... including
> devfs support), maked a initrd image with the necessary modules to mount
> the / partition (sata modules, file system modules...) and changed the
> disks names in the /etc/fstab from hda to sda (as it is recognized at
> 2.6.12.6 kernel bootup process). The laptop model is IBM Thinkpad T43.

That hda to sda looks funny.  I didn't know the T43 has a SCSI (which I'm
pretty sure it doesn't).

>
> Any ideia? Anybody knows why it is happen?
>
Are you sure the initrd was correctly made. That pivot_root seems to
suggest that it wasn't.  You're using Debian. When I went from 2.4 to 2.6
I just used aptitude (or apt-get) to get the 2.6 kernel first, and let the
package manager make all the necessary changes for me.  I also usually
don't use an initrd and just compile in the drivers for my ide and
filesystems.

-- Steve

