Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSGXTP7>; Wed, 24 Jul 2002 15:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317567AbSGXTP7>; Wed, 24 Jul 2002 15:15:59 -0400
Received: from monster.nni.com ([216.107.0.51]:34057 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317566AbSGXTP5>;
	Wed, 24 Jul 2002 15:15:57 -0400
Date: Wed, 24 Jul 2002 15:19:04 -0400
From: Andrew Rodland <arodland@noln.com>
To: Kareem Dana <kareemy@earthlink.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop.o device busy after umount
Message-Id: <20020724151904.3d719dea.arodland@noln.com>
In-Reply-To: <20020724145919.01c79fce.kareemy@earthlink.net>
References: <20020724145919.01c79fce.kareemy@earthlink.net>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 14:59:19 -0400
Kareem Dana <kareemy@earthlink.net> wrote:

> Hello,
> 
> I've noticed in kernel 2.4.18 that my loop module remains busy after I
> umount the device using it. For example
> 
> mount -t iso9660 -o loop file.iso /mnt
> * loop module gets loaded
> * lsmod shows "loop                    7952   1 (autoclean)"
> * ps ax shows [loop0] process
> 
> then
> umount /mnt
> lsmod shows the same thing - specifically the use of loop as 1 and the
> [loop0] process remains open. Trying to rmmod loop gives me a device
> or resource busy error.

For some reason or other, umount didn't losetup -d the device.

Try losetup -d /dev/loop0, and see whether it does what you want, or
returns some sort of error.

--hobbs
