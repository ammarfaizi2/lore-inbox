Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTASAhi>; Sat, 18 Jan 2003 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbTASAhi>; Sat, 18 Jan 2003 19:37:38 -0500
Received: from packet.digeo.com ([12.110.80.53]:48277 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265270AbTASAhh>;
	Sat, 18 Jan 2003 19:37:37 -0500
Date: Sat, 18 Jan 2003 16:48:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
Message-Id: <20030118164805.1481f74c.akpm@digeo.com>
In-Reply-To: <1042933992.3470.31.camel@garaged.fis.unam.mx>
References: <1042932078.3476.25.camel@garaged.fis.unam.mx>
	<20030118154414.607df22b.akpm@digeo.com>
	<1042933992.3470.31.camel@garaged.fis.unam.mx>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jan 2003 00:46:32.0855 (UTC) FILETIME=[36469A70:01C2BF54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Valdez <maxvaldez@yahoo.com> wrote:
>
> >Your ext3 filesystem is being built as a module, so you are dependent
> >upon
> >correct initrd setup to be able to mount the other filesystems.  If
> >those
> >filesystems were not cleanly shut down, ext2 will not be able to mount
> >them.
> 
> >Or something like that.  Try setting CONFIG_EXT3_FS=y.
> 
> I do have EXT3_FS=m

Try it with "y"
 
> But I did a correct initrd build,

You haven't set CONFIG_BLK_DEV_INITRD

> / mount is ext3, and gets mounted ok,

It's probably mounted as ext2.  Check /proc/mounts.


