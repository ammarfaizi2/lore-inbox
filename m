Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290730AbSBFSRL>; Wed, 6 Feb 2002 13:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSBFSRE>; Wed, 6 Feb 2002 13:17:04 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:9220 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S290729AbSBFSQw>; Wed, 6 Feb 2002 13:16:52 -0500
Message-Id: <4.3.2.7.2.20020206131121.00b1f670@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 06 Feb 2002 13:16:58 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <20020206172423.3967123CD3@persephone.dmz.logatique.fr>
In-Reply-To: <20020206162657.GD534915@niksula.cs.hut.fi>
 <m3ofj2galz.fsf@linux.local>
 <E16YSs7-0005GY-00@the-village.bc.nu>
 <20020206162657.GD534915@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:26 PM 2/6/02, you wrote:


>... snip ...
>
>         * having /usr/src/linux/patches is not practical : it will be a 
> big mess wrt
>to conflict

Indeed, if /usr/src/linux/patches was a file, the conflicts would be 
impossible to manage.  But suppose it was a directory and each patch 
created a small description file in that directory.  This would provide the 
desired information without having the big mess :-)

It's been suggested that config info be saved using the following:

         <.config sed -e '/^#/d' -e '/^[    ]*$/d' | gzip -9 >> image

The patch descriptions could be saved in a similar manner:

         cat /usr/src/linux/patches/* | gzip -9 >> image

Alternatively, instead of outputting to image, one could output to 
/boot/patch-$KERNELVERSION, (or wherever)

David


