Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRDNHyk>; Sat, 14 Apr 2001 03:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129359AbRDNHya>; Sat, 14 Apr 2001 03:54:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47631 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129346AbRDNHyP>;
	Sat, 14 Apr 2001 03:54:15 -0400
Date: Sat, 14 Apr 2001 09:54:02 +0200
From: Jens Axboe <axboe@suse.de>
To: Arthur Pedyczak <arthur-p@home.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: loop problems continue in 2.4.3
Message-ID: <20010414095402.C20299@suse.de>
In-Reply-To: <Pine.LNX.4.33.0104132330560.1677-100000@cs865114-a.amp.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0104132330560.1677-100000@cs865114-a.amp.dhs.org>; from arthur-p@home.com on Fri, Apr 13, 2001 at 11:35:02PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13 2001, Arthur Pedyczak wrote:
> Hi all,
> here are my $0.02 regarding loop in 2.4.3.
> 
> 1. mounted file
> mount -t iso9660 -o loop file.img /mnt/cdrom
>     worked o.k.
> 2. unmounted
> umount /mnt/cdrom
>     worked o.k.
> 3. mounted file
> mount -t iso9660 -o loop file.img /mnt/cdrom
>     worked o.k.
> 4. tried to unmount
> umount /mnt/cdrom
>    got oops:
> 
> =====================
> Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging request at virtual address 7e92bfd7

Please disable syslog decoding (it sucks) and feed it through ksymoops
instead.

In other words, reproduce and dmesg | ksymoops instead.

-- 
Jens Axboe

