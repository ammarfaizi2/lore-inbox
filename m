Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132693AbRDOQPn>; Sun, 15 Apr 2001 12:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132695AbRDOQPe>; Sun, 15 Apr 2001 12:15:34 -0400
Received: from s340-modem2169.dial.xs4all.nl ([194.109.168.121]:6280 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S132693AbRDOQP3>;
	Sun, 15 Apr 2001 12:15:29 -0400
Date: Sun, 15 Apr 2001 20:14:30 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>, <linux-lvm@sistina.com>
Subject: Re: 2.4.4-pre3: lvm.c patch results in "hanging" mount or swapon
In-Reply-To: <20010415162451.F1982@suse.de>
Message-ID: <Pine.LNX.4.31.0104152010320.1047-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, 15 Apr 2001, Jens Axboe wrote:

> On Sun, Apr 15 2001, Arjan Filius wrote:
> > Hello,
> >
> > While trying kernel 2.4.4-pre3 i found a "hanging" swapon (my swap is on
> > LVM), same effect for "mount -a". 2.4.3 works properly.
> >
> > I found ./drivers/md/lvm.c is patched, and restoring the lvm.c from 2.4.3
> > resulted in normal operation.
> >
> > I Found LVM/0.9.1_beta7 makes some notes about the patch, so i tried that
> > (beta7), but no luck, only 2.4.3:lvm.c worked ok.
>
> Small buglet in the buffer_IO_error out path, I maybe that's it...

Dunno, i did som 'strace'ing and found it is waiting in read():
open("/dev/vg_4/lv_images", O_RDONLY)   = 4
lseek(4, 1024, SEEK_SET)                = 1024
read(4,
      (killed with SAK)


Greatings,



-- 
Arjan Filius
mailto:iafilius@xs4all.nl

