Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317698AbSFLNrR>; Wed, 12 Jun 2002 09:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317704AbSFLNrQ>; Wed, 12 Jun 2002 09:47:16 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:46062 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317698AbSFLNrP>; Wed, 12 Jun 2002 09:47:15 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <15623.11051.890868.154587@wombat.chubb.wattle.id.au> 
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 14:47:08 +0100
Message-ID: <17385.1023889628@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




peter@chubb.wattle.id.au said:
> This issue is that when I try to use the BLKGETSZ64 ioctl from a user
> space program, the version of linux/fs.h shipped with glibc-2.2.5
> contains a u64 type. 

>  You could argue that this is a glibc bug.

I do indeed. I further argue that it has no business being discussed on the 
kernel mailing list, just because the kernel happens to have a header with 
a similar name.

> But the way that glibc generates the include/linux headers is just 
> to copy them from some kernel tree or other, with a little mangling
> on the side.

This errant behaviour would appear to be the cause of the bug you've
observed. Glibc should be providing its own header files.

--
dwmw2


