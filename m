Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265297AbUAAEEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 23:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAAEEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 23:04:35 -0500
Received: from mail.rdslink.ro ([193.231.236.20]:41109 "EHLO mail.rdslink.ro")
	by vger.kernel.org with ESMTP id S265297AbUAAEEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 23:04:33 -0500
Date: Thu, 1 Jan 2004 06:05:29 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problem with 2.6.0
In-Reply-To: <20031227194144.54d052d1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0401010559330.687@grinch.ro>
References: <Pine.LNX.4.53.0312271912350.511@grinch.ro>
 <20031227194144.54d052d1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003, Andrew Morton wrote:

> caszonyi@rdslink.ro wrote:
> >
> > I have a small script:
> >  #!/bin/sh
> >  umount /mnt/cdrom
> >  eject /dev/hdb
> >  echo "Invalid system disk"
> >  echo "Insert and press any key when ready"
> >  read junk
> >  eject -t /dev/hdb
> >  sleep 1
> >  mount /mnt/cdrom
> >  /usr/sbin/hdparm -E 10 /dev/hdb
> >
> >  It works all the time but today gave me this:
> >
> >  In the logs I had:
> >  Dec 27 19:06:16 grinch kernel: eject: page allocation failure. order:4,
> >  mode:0xd0
>
> Please, try
>
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/cdrom-allocation-try-harder.patch
>
> and let me know?
>

for cdrom it *seems* to work.

The problem continues however for other applications
It is not specific to the ide-cd driver. The same problem happens
sometimes
with mplayer also

Dec 30 22:07:12 grinch kernel: mplayer: page allocation failure. order:4,
mode:0x21
