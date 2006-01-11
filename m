Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWAKWrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWAKWrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWAKWrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:47:37 -0500
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:10886 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932487AbWAKWrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:47:36 -0500
Message-ID: <43C58B02.6010601@ens-lyon.org>
Date: Wed, 11 Jan 2006 17:47:30 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org> <43C54FB9.9080906@ens-lyon.org> <20060111184012.GA19604@isilmar.linta.de> <43C55761.1090106@ens-lyon.org> <20060111195553.GA15739@isilmar.linta.de> <43C56A6C.8020707@ens-lyon.org> <20060111212135.GA32021@isilmar.linta.de>
In-Reply-To: <20060111212135.GA32021@isilmar.linta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:

>Exactly. Could you pass the parameter pc_debug=9 to the "pcmcia" module,
>please, and send me the resulting dmesg? I can't reproduce it here,
>unfortunately...
>  
>
Here you are (I had to enable CONFIG_PCMCIA_DEBUG).
Brice


ds: ds_open(socket 0)
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please
expect breakage unless you upgrade to new tools.
pcmcia: see
http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
ds: ds_open(socket 1)
ds: ds_open(socket 1)
ds: ds_ioctl(socket 0, 0xc0146402, 0x8070358)
cs: IO port probe 0x100-0x4ff: excluding 0x3f0-0x3ff 0x4d0-0x4d7
ds: ds_ioctl(socket 0, 0xc0146402, 0x8070378)
cs: IO port probe 0x800-0x8ff: clean.
ds: ds_ioctl(socket 0, 0xc0146402, 0x8070398)
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
ds: ds_ioctl(socket 0, 0xc0146402, 0x80703b8)
ds: ds_ioctl(socket 0, 0xc0146402, 0x80703d8)
ds: ds_ioctl(socket 0, 0xc0146402, 0x80703f8)
ds: ds_ioctl(socket 0, 0xc0146402, 0x8070418)
cs: IO port probe 0xa00-0xaff: clean.
ds: ds_ioctl(socket 0, 0xc0146402, 0x8070438)
ds: ds_ioctl(socket 0, 0xc0146402, 0x8070458)
ds: ds_ioctl(socket 0, 0xc00c6409, 0xbf9fd974)
BUG: atomic counter underflow at:
 [<c01a0921>] kref_put+0x4d/0x68
 [<c01a0051>] kobject_put+0x16/0x19
 [<c01a0475>] kobject_release+0x0/0xa
 [<e0a3abfa>] ds_ioctl+0x3dd/0x781 [pcmcia]
 [<c0153301>] do_ioctl+0x3d/0x4e
 [<c01534fc>] vfs_ioctl+0x1ea/0x1fb
 [<c0153538>] sys_ioctl+0x2b/0x47
 [<c0102a2d>] syscall_call+0x7/0xb
ds: ds_ioctl: ret = 20
ds: ds_poll(socket 0)
ds: ds_poll(socket 0)

