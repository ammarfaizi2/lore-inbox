Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129506AbRB1Pcc>; Wed, 28 Feb 2001 10:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130217AbRB1PcX>; Wed, 28 Feb 2001 10:32:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17541 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129506AbRB1PcE> convert rfc822-to-8bit; Wed, 28 Feb 2001 10:32:04 -0500
Date: Wed, 28 Feb 2001 10:31:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Holluby István <holluby@interware.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs /dev/loop0
In-Reply-To: <Pine.LNX.4.33.0102281545120.1836-100000@cica.khb.hu>
Message-ID: <Pine.LNX.3.95.1010228102221.4469A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Holluby [Windows-1250] István holluby@interware.hu wrote:

> 	Hi!
> 
> This command hangs my system. It works for a 100K file, but it hangs my
> system, if the file is 470M. It does not matter, if the disk is SCSI or
> ide.
> 
> linux 2.4.2
> glibc-2.2.2
> gcc-2.95.2.1
> e2fs-1.19
> 
> With kernel 2.2.18, it works fine.
> 
> ===============
> I also have some problem, with ncpfs. I am not quite sure, because I had to
> hack the source, to compile it, but the same hack works with 2.2.18.
> 

`mke2fs /dev/loop0`  requires an additional parameter (file size to
create). Otherwise, it will try to use all the RAM in your system, plus...

If it worked before, it was because of luck. FYI, this is not the
way to create a ramdisk. Normally you use the loop device to mount
a file as a file-system, i.e., `mount -o loop filename /mnt`.
So, I don't know what you are trying to do except crash your system.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


