Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSJXMGU>; Thu, 24 Oct 2002 08:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265409AbSJXMGT>; Thu, 24 Oct 2002 08:06:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34951 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265402AbSJXMGT>; Thu, 24 Oct 2002 08:06:19 -0400
Date: Thu, 24 Oct 2002 08:13:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: yf <fyou@dsguardian.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: pls help me
In-Reply-To: <1035441048.727.3.camel@yf.dsguardian.com>
Message-ID: <Pine.LNX.3.95.1021024080900.18436A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Oct 2002, yf wrote:

> Hi, all, 
> 
> Recently I wrote a file-system under Linux. When mounting, it prints 
> these messages. I use iget(sb, ino) to get the root inode. 
> 
> But when run into get_new_inode():wake_up(), it hangs there. Who could 
> give me some hints? 
> 
> what the dmesg output: 
> ************************************************************************
> 
> ==> vvfs_init() 
> ==> vvfs_read_super(<NULL>) 
> ==> vvfs_connect(192.168.1.57, 52886) 
> 2, 38606, 956410048 
> <== vvfs_connect()OK 
> superblock ordinary filling ok 
> ==> vvfs_alloc_inode() 
> <== vvfs_alloc_inode() 
> ==> vvfs_read_inode(c67fb000) 
> get sb sock 
> get inode fid 
> root inode 
> fetch inode OK 
> set server info OK 
> <== vvfs_read_inode()c67fb000 
> Unable to handle kernel paging request at virtual address fffffffc 

There is no way somebody can help you with "Recently I wrote a file-
system...." We don't have your source-code and we don't even know if
you know how to write a file-system. However, the -
  Unable to handle kernel paging request at virtual address fffffffc 
- is a good hint that some pointer isn't initialized correctly under
all the conditions occurring during the mount.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


