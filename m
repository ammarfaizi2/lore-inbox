Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265177AbTARXdr>; Sat, 18 Jan 2003 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265197AbTARXdr>; Sat, 18 Jan 2003 18:33:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:4501 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265177AbTARXdr>;
	Sat, 18 Jan 2003 18:33:47 -0500
Date: Sat, 18 Jan 2003 15:44:14 -0800
From: Andrew Morton <akpm@digeo.com>
To: Max Valdez <maxvaldez@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why kernel 2.5.58 only mounts / (not home etc)
Message-Id: <20030118154414.607df22b.akpm@digeo.com>
In-Reply-To: <1042932078.3476.25.camel@garaged.fis.unam.mx>
References: <1042932078.3476.25.camel@garaged.fis.unam.mx>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 23:42:42.0311 (UTC) FILETIME=[4B17F970:01C2BF4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Valdez <maxvaldez@yahoo.com> wrote:
>
> I'm having a problem with 2.5.58, when I boot I get / mounted, but not
> the other entries on fstab, but if I mount them manually they run ok.
> All ext3.
> 
> Is anybody having the same problem ?
> mount-2.11u, e2fsprogs-1.27-4mdk
> on MDK 9.0.
> 

Your ext3 filesystem is being built as a module, so you are dependent upon
correct initrd setup to be able to mount the other filesystems.  If those
filesystems were not cleanly shut down, ext2 will not be able to mount them.

Or something like that.  Try setting CONFIG_EXT3_FS=y.


