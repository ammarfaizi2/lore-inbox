Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWAKStc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWAKStc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWAKStc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:49:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932539AbWAKStc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:49:32 -0500
Date: Wed, 11 Jan 2006 10:49:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: 2.6.15-mm3
Message-Id: <20060111104912.440fa3d7.akpm@osdl.org>
In-Reply-To: <43C54FB9.9080906@ens-lyon.org>
References: <20060111042135.24faf878.akpm@osdl.org>
	<43C54FB9.9080906@ens-lyon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
> 
> 
> Hi Andrew,
> 
> I am seeing the following message (which does not seem to cause any
> problem):
> 
> pcmcia: Detected deprecated PCMCIA ioctl usage.
> This interface will soon be removed from the kernel; please expect
> breakage unless you upgrade to new tools.
> pcmcia: see
> http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
> cs: IO port probe 0x100-0x4ff: excluding 0x3f0-0x3ff 0x4d0-0x4d7
> cs: IO port probe 0x800-0x8ff: clean.
> cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
> cs: IO port probe 0xa00-0xaff: clean.
> BUG: atomic counter underflow at:
>  [<c01a0921>] kref_put+0x4d/0x68
>  [<c01a0051>] kobject_put+0x16/0x19
>  [<c01a0475>] kobject_release+0x0/0xa
>  [<e0a40b20>] ds_ioctl+0x380/0x6e8 [pcmcia]
>  [<c0153301>] do_ioctl+0x3d/0x4e
>  [<c01534fc>] vfs_ioctl+0x1ea/0x1fb
>  [<c0153538>] sys_ioctl+0x2b/0x47
>  [<c0102a2d>] syscall_call+0x7/0xb
> 
> Any idea about what patch I could revert ?

git-pcmcia-ssh-needs-mutexh.patch and then git-pcmcia.patch, I expect.
