Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266255AbUBLBwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 20:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUBLBwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 20:52:33 -0500
Received: from gaia.cela.pl ([213.134.162.11]:49937 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S266255AbUBLBwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 20:52:31 -0500
Date: Thu, 12 Feb 2004 02:52:26 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Steve G <linux_4ever@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vfat increases file permissions
In-Reply-To: <20040211224433.92148.qmail@web9602.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0402120251170.32503-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


my fstab entry seems to work quite well:
/dev/hda1 /c vfat defaults,nosuid,nodev,quiet,umask=0000,showexec,noatime 0 0 # noexec

On Wed, 11 Feb 2004, Steve G wrote:

> Hello,
> 
> I am wondering about something. Why is it that when I mount a
> vfat floppy disk and copy a file to the disk, it becomes
> executable?
> 
> [root@linux fd_test]# umask 277
> [root@linux fd_test]# touch test.txt
> [root@linux fd_test]# ls -l test.txt
> -r--------    1 root     root            0 Feb 11 17:20 test.txt
> [root@linux fd_test]# cp test.txt /mnt/floppy/
> [root@linux fd_test]# ls -l /mnt/floppy/test.txt
> -rwxrwxrwx    1 root     root            0 Feb 11 17:20
> /mnt/floppy/test.txt
> 
> In the DOS world, not every file is executable. It uses the file
> extention to decide if the file is executable. A text file is not
> implicitly executable unless it has a .bat file extention.
> 
> Is the Linux implementation interpreting something that doesn't
> actually exist in the original?
> 
> I am concerned about world writeable, executable files existing
> on my floppies or USB devices that are formatted vfat. This seems
> like a security concern to me.
> 
> Thanks,
> Steve Grubb
> 
> __________________________________
> Do you Yahoo!?
> Yahoo! Finance: Get your refund fast by filing online.
> http://taxes.yahoo.com/filing.html
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

