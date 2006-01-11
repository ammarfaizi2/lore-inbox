Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWAKSkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWAKSkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWAKSkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:40:16 -0500
Received: from isilmar.linta.de ([213.239.214.66]:63947 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751715AbWAKSkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:40:14 -0500
Date: Wed, 11 Jan 2006 19:40:12 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
Message-ID: <20060111184012.GA19604@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C54FB9.9080906@ens-lyon.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 11, 2006 at 01:34:33PM -0500, Brice Goglin wrote:
> Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
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

git-pcmcia . I'll look at what's broken. Thanks for reporting this.

	Dominik
