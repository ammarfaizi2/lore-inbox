Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317497AbSGXTaL>; Wed, 24 Jul 2002 15:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGXTaK>; Wed, 24 Jul 2002 15:30:10 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:60186 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S317497AbSGXTaK>; Wed, 24 Jul 2002 15:30:10 -0400
Date: Wed, 24 Jul 2002 15:33:19 -0400
From: Kareem Dana <kareemy@earthlink.net>
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
Message-Id: <20020724153319.5ebd589b.kareemy@earthlink.net>
In-Reply-To: <20020724151904.3d719dea.arodland@noln.com>
References: <20020724145919.01c79fce.kareemy@earthlink.net>
	<20020724151904.3d719dea.arodland@noln.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 15:19:04 -0400
Andrew Rodland <arodland@noln.com> wrote:

> On Wed, 24 Jul 2002 14:59:19 -0400
> Kareem Dana <kareemy@earthlink.net> wrote:
> 
> > Hello,
> > 
> > I've noticed in kernel 2.4.18 that my loop module remains busy after I
> > umount the device using it. For example
> > 
> > mount -t iso9660 -o loop file.iso /mnt
> > * loop module gets loaded
> > * lsmod shows "loop                    7952   1 (autoclean)"
> > * ps ax shows [loop0] process
> > 
> > then
> > umount /mnt
> > lsmod shows the same thing - specifically the use of loop as 1 and the
> > [loop0] process remains open. Trying to rmmod loop gives me a device
> > or resource busy error.
> 
> For some reason or other, umount didn't losetup -d the device.
> 
> Try losetup -d /dev/loop0, and see whether it does what you want, or
> returns some sort of error.
> 
> --hobbs
umount: mount-2.11r

losetup worked like a charm. Thanks. Any reason umount would not do that automatically though?
umount -V returns umount: mount-2.11r

- Kareem
