Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266129AbRGPFLw>; Mon, 16 Jul 2001 01:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267156AbRGPFLm>; Mon, 16 Jul 2001 01:11:42 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:37127 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S266129AbRGPFLh>; Mon, 16 Jul 2001 01:11:37 -0400
Date: Mon, 16 Jul 2001 00:11:39 -0500 (EST)
From: Adam <adam@eax.com>
X-X-Sender: <adam@eax.student.umd.edu>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib 
In-Reply-To: <Pine.LNX.4.33.0107160548400.3655-100000@tahallah.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0107160009260.25850-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just found a pair of '..' directories in the /lib directory. e2fsck 1.19
> didn't even pick up on this!
> /lib
>    4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
>    4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..
>
> How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.

first it is not a pair directories, but a directory and a file.

second, are you sure both of the mare just ".." for example

	eax /tmp % touch ".. "
	eax /tmp % ls -la | grep "\.\."
	drwxr-xr-x   23 root     root         1024 Sep 16  2000 ..
	-rw-rw-r--    1 adam     adam            0 Jul 16 01:09 ..

so use 'od' to see what the filename is composed of:

	eax /tmp % ls -la | grep "\.\." | od -a
	 .   .  sp  nl

-- 
Adam
http://www.eax.com      The Supreme Headquarters of the 32 bit registers


