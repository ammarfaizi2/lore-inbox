Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291318AbSBSLz7>; Tue, 19 Feb 2002 06:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291320AbSBSLzu>; Tue, 19 Feb 2002 06:55:50 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:1710 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S291318AbSBSLz2>; Tue, 19 Feb 2002 06:55:28 -0500
Date: Tue, 19 Feb 2002 12:52:11 +0100
From: Kristian <kristian.peters@korseby.net>
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.18-pre9-ac4 filesystem corruption
Message-Id: <20020219125211.10f80f4e.kristian.peters@korseby.net>
In-Reply-To: <20020218115143.A13070@mail.harddata.com>
In-Reply-To: <20020218115143.A13070@mail.harddata.com>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: Debian GNU/Linux 2.4.17
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've seen filesystem corruption using -ac4 with ext2 although I'm not using a SIS chipset. So I really recommend using not this patch.

PS: This may have nothing in common with your problem cause I encountered these corruption on Intel.

Yesterday:

kernel: init_special_inode: bogus imode (177777) 
kernel: init_special_inode: bogus imode (177777) 
kernel: init_special_inode: bogus imode (167777) 
kernel: init_special_inode: bogus imode (177777) 
last message repeated 2 times 
kernel: init_special_inode: bogus imode (177767) 
kernel: init_special_inode: bogus imode (177767) 
kernel: init_special_inode: bogus imode (137777) 
kernel: init_special_inode: bogus imode (167777) 
kernel: init_special_inode: bogus imode (177777) 
kernel: init_special_inode: bogus imode (177757) 
kernel: init_special_inode: bogus imode (177677) 
kernel: init_special_inode: bogus imode (177777) 
last message repeated 2 times 
kernel: init_special_inode: bogus imode (177377) 
kernel: init_special_inode: bogus imode (177777) 

after fsck-ing:

kernel: init_special_inode: bogus imode (0) 
kernel: init_special_inode: bogus imode (0) 
kernel: init_special_inode: bogus imode (20) 
kernel: init_special_inode: bogus imode (0) 
kernel: init_special_inode: bogus imode (10) 
kernel: init_special_inode: bogus imode (0) 
last message repeated 6 times 
kernel: init_special_inode: bogus imode (20) 
kernel: init_special_inode: bogus imode (0) 
last message repeated 3 times 

Today:

kernel: init_special_inode: bogus imode (0) 
kernel: init_special_inode: bogus imode (35623) 
kernel: init_special_inode: bogus imode (0) 
kernel: init_special_inode: bogus imode (30070) 
kernel: init_special_inode: bogus imode (30061) 
kernel: init_special_inode: bogus imode (0) 
kernel: init_special_inode: bogus imode (35623) 
kernel: init_special_inode: bogus imode (0) 

I'm using -rc2 now and compiling 5 kernels at the same time and haven't seen any of those problems yet.

*Kristian

Michal Jaegermann <michal@harddata.com> wrote:
> ..........
> FAT: bogus logical sector size 0
> FAT: bogus logical sector size 0
> Kernel panic: VFS: Unable to mount root fs on 03:00

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :..........................:
