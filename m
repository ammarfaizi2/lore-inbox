Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbSJSJeJ>; Sat, 19 Oct 2002 05:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbSJSJeI>; Sat, 19 Oct 2002 05:34:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4108 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263016AbSJSJeH>; Sat, 19 Oct 2002 05:34:07 -0400
Message-Id: <200210190935.g9J9Z9p15259@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
Subject: Re: Forced umount
Date: Sat, 19 Oct 2002 14:28:02 +0000
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1021018151840.150A-100000@chaos.analogic.com> <3DB06E3D.8050704@gmx.net>
In-Reply-To: <3DB06E3D.8050704@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 October 2002 20:25, Carl-Daniel Hailfinger wrote:
> Richard B. Johnson wrote:
> > In other words, if I have quark:/tmp mounted on /tmp, I can
> > umount / without unmounting quark:/tmp.

You can remount ro. I doubt you can umount.

> >
> > [SNIPPED]
>
> Does not work here.
>
> # mount /dev/fd0 /floppy/
> # mount /dev/hda1 /floppy/test/
> # umount /floppy/
> umount: /media/floppy: device is busy
> # touch /floppy/foo
> umount -f /floppy/
> umount2: Device or resource busy
> umount: /dev/fd0: not mounted
> umount: /media/floppy: Illegal seek
> # touch /floppy/foo2
> # mount
> /dev/fd0 on /floppy type vfat (rw,sync)
> /dev/hda1 on /floppy/test type vfat (rw)
>
> In other words, your suggested method does not work here. (Kernel
> 2.4.18, util-linux-2.11n)
>
> # mount -o remount,ro /floppy/
> /dev/fd0 on /floppy type vfat (ro,sync)
> /dev/hda1 on /floppy/test type vfat (rw)
>
> This, however, seems to work.

umount / is special: in fact it does remount ro.
So you two do the same thing.
--
vda
