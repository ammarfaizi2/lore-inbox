Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWBBWpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWBBWpf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWBBWpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:45:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932389AbWBBWpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:45:34 -0500
Date: Thu, 2 Feb 2006 14:47:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060202144732.05f7bf32.akpm@osdl.org>
In-Reply-To: <20060202232858.0c5d5e9a@werewolf.auna.net>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060202232858.0c5d5e9a@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On Sun, 29 Jan 2006 14:45:33 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/
> > 
> >
> 
> I have problems with ide-floppy.
> Do not know if they are specific to this latest release, as I did not use
> my ZIP drive since long ago...Now I tried to make a boot zip with grub.
> 
> I inserted a mac floppy, partitioned it as hdb1, and as soon as fdisk wrote
> the partition table and forced a reread, the system began to scan the
> zip like crazy, and nothing appears on /proc/partitions ...
> 
> Ejected the disk, rmmod ide-floppy, insert the disk and everything is quiet.
> As soon as insmod ide-floppy, the party starts on syslog:
> 
> ide-floppy driver 0.99.newide
> hdb: 244766kB, 489532 blocks, 512 sector size
> hdb: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
> hdb: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
> hdb: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
> hdb: hdb1
> 
> <last 3 messages repeated forever>
> 

>From my reading of the code, the above should have been a once-off warning
and the driver should have proceeded happily.  Strange that it repeated
those messages forever.

I guess the next step is to try some earlier kernels.
