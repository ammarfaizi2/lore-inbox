Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277792AbRJLR2Z>; Fri, 12 Oct 2001 13:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277798AbRJLR2Q>; Fri, 12 Oct 2001 13:28:16 -0400
Received: from [134.122.1.73] ([134.122.1.73]:35849 "EHLO scl-ims.phoenix.com")
	by vger.kernel.org with ESMTP id <S277792AbRJLR2L>;
	Fri, 12 Oct 2001 13:28:11 -0400
Message-ID: <D973CF70008ED411B273009027893BA401BE6C34@irv-exch.phoenix.com>
From: David Christensen <David_Christensen@Phoenix.com>
To: "'hanhbkernel'" <hanhbkernel@yahoo.com.cn>, linux-kernel@vger.kernel.org
Subject: RE: initrd problem of 2.4.10
Date: Fri, 12 Oct 2001 10:02:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="gb2312"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no problem using the initial RAM disk
> (initrd) with kernel 2.4.9
> But with kernel 2.4.10 system reports the following
> messages:
> 
> RAMDISK: compressed image found at block 0
> Freeing initrd memory: 1153k freed
> VFS: Mounted root (ext2 filesystem)
> Freeing unused kernel (memory: 224k freed)
> Kernel panic: No init found. Try passing init=option
> to kernel
> 
> When I compile the 2.4.10 The following option is
> supported:
> <*> RAM disk support(128000)   Default RAM disk size  

This is an unusually large size (128MB).  Is your ramdisk
really that large?  Try reducing this to a more sane value
(say 4096) and add the "ramdisk=" line to your /etc/lilo.conf
if your ramdisk goes above 4MB.

>                            
> [*]   Initial RAM disk (initrd) support   
> 
> The version of lilo is 21.6. My lilo.conf is as this:
> boot=/dev/hda
> map=/boot/map
> install=/boot/boot.b
> prompt
> timeout=50
> message=/boot/message
> linear
> default=CapitelFW-2.4.9
> image=/hda2/boot/linux-2.4.91
> 	label=CapitelFW-2.4.9
> 	initrd=/hda2/root/initrd.gz
> 	append="root=/dev/ram0 init=linuxrc rw"
> image=/hda2/boot/linux-2.4.10-ac
> 	label=CapitelFW-ac12
> 	initrd=/hda2/root/initrd.gz
> 	append="root=/dev/ram0 init=linuxrc rw"
