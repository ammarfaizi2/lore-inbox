Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280118AbRJaJXB>; Wed, 31 Oct 2001 04:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280117AbRJaJWl>; Wed, 31 Oct 2001 04:22:41 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:65380 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280116AbRJaJWf>; Wed, 31 Oct 2001 04:22:35 -0500
Date: Wed, 31 Oct 2001 11:23:03 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Riley Williams <rhw@MemAlpha.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
Message-ID: <20011031112303.A26218@niksula.cs.hut.fi>
In-Reply-To: <20011030035221.6E5611FE7D@varmo.pacujo.nu> <Pine.LNX.4.21.0110310046000.19579-100000@Consulate.UFP.CX>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110310046000.19579-100000@Consulate.UFP.CX>; from rhw@MemAlpha.cx on Wed, Oct 31, 2001 at 12:51:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 12:51:29AM +0000, you [Riley Williams] claimed:
> Hi Marko.
> 
> > PS Are /dev/null and /dev/zero also redundant?
> 
> I regularly use both...
> 
>  1. Find a download that doesn't appear where one expected it...
> 
> 	find / -name "wanted-but-lost-download" 2> /dev/null
> 
>  2. Create a loop-mounted partition to populate as a CD image before
>     burning the CD in question.
> 
> 	dd if=/dev/zero bs=1048576 count=750 of=/tmp/cd.img
> 	mke2fs /tmp/cd.img
> 	mount -o loop /tmp/cd.img /img/cd
> 
>  3. Create a loop-mounted partition to populate as a floppy image.
> 
> 	dd if=/dev/zero bs=1024 count=1440 of=/tmp/floppy.img
> 	mke2fs /tmp/floppy.img
> 	mount -o loop /tmp/floppy.img /img/floppy
> 
> Neither has alternatives that make sense as far as I can see.

Certainly have in the sense that you could theoretically do that in user
space.

find / -name "wanted-but-lost-download" | eat
zerofill | head -c 1440k > /tmp/floppy.img
ssh foo@bar | block

etc.
 
(Implementation of eat, block and zerofill is left as an exercise...)


-- v --

v@iki.fi
