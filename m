Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbRENN7f>; Mon, 14 May 2001 09:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbRENN7Y>; Mon, 14 May 2001 09:59:24 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:36366 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261390AbRENN7L>; Mon, 14 May 2001 09:59:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Blesson Paul <blessonpaul@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: How VFS interacts with a file driver
Date: Mon, 14 May 2001 15:55:18 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010514052904.22912.qmail@nwcst340.netaddress.usa.net>
In-Reply-To: <20010514052904.22912.qmail@nwcst340.netaddress.usa.net>
MIME-Version: 1.0
Message-Id: <01051415551805.02742@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 May 2001 07:29, Blesson Paul wrote:
> Hi
>                I am trying to implement a distributed file system.
> For that I write a file driver. I want to know the following things
>
> 1 . If I am writing a new file system, is it necessary to modify the
> existing structs including inode struct.
> 2 . If it is not needed, will a simple registration of the file
> system is needed to mount the file system
>                 More over I am new to this area. I am doing as my
> graduate project. I need someones help to crack the working of VFS
> Thanks in advance

1. In .config, change CONFIG_EXT2_FS to 'm'
2. change "ext2" to "newfs" at DECLARE_FSTYPE_DEV in super.c
3. make modules SUBDIRS=fs/ext2
4. insmod fs/ext2/ext2.o

Poof!  New filesystem.  (cat /proc/filesystems) Don't forget to change 
ext2 in .config back to "y" before you build your next kernel.  You'll 
need to study the kernel *hard* before you can expect to have half a 
chance of having your filesystem work properly.  Go here:

  http://lksr.org

and here:

  http://kernelnewbies.org

--
Daniel
