Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135596AbRA0Vne>; Sat, 27 Jan 2001 16:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135640AbRA0VnY>; Sat, 27 Jan 2001 16:43:24 -0500
Received: from blackdog.wirespeed.com ([208.170.106.25]:41234 "EHLO
	blackdog.wirespeed.com") by vger.kernel.org with ESMTP
	id <S135596AbRA0VnI>; Sat, 27 Jan 2001 16:43:08 -0500
Message-ID: <3A73419E.7070900@redhat.com>
Date: Sat, 27 Jan 2001 15:46:06 -0600
From: Joe deBlaquiere <jadb@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: rhairyes@lee.k12.nc.us
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel boot problems
In-Reply-To: <98062913115550-27145815550rhairyes@lee.k12.nc.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few things come to mind:

1. Is your init statically linked or linked with shared libraries? If 
it's shared, do you have all the shared objects on your disk image in a 
place where they can be found (/lib, I hope)? You might try linking it 
statically (but stripped) just to make sure.

2. Is it in the path that the kernel is looking in? check init/main.c to 
see what your kernel is looking for (it's some educational reading anyway).

3. Even if 'init' isn't found, it should try to run /bin/sh as a last 
resort. I can't imagine you don't have one of those.

4. Is init executable?

5. "unable to open an initial console" probably means you don't have the 
necesary device nodes (refer to init/main.c)

6. If this doesn't help, there is a ramdisk FAQ that is well written...

Good luck with it!

Joe

Ryan Hairyes wrote:

> Hello all,
> 
> I was wondering if someone might be able to help me.
> I have just compiled my kernel and set it up on a floppy
> to boot off a disk.  I have it then use an image file to uncompress
> and get the filesystem off ,etc.  Well when it boots it says it has
> uncompressed the filesystem image and then gives me this:
> Mounted Root (ext2 filesystem) readonly
> Freeing unused kernel memory: 212K freed
> Warning: unable to open an initial console
> Kernel panic: no init found. Try passing init= option to the kernel.
> 
> I know that I have init on the image, so what could I be doing wrong.
> It is probably something stupid that I am overlooking, but I thank you in
> advance.
>               
> Ryan                     
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
