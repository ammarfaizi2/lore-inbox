Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261591AbSJAMNL>; Tue, 1 Oct 2002 08:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261592AbSJAMNL>; Tue, 1 Oct 2002 08:13:11 -0400
Received: from tbaytel3.tbaytel.net ([206.47.150.179]:15338 "EHLO tbaytel.net")
	by vger.kernel.org with ESMTP id <S261591AbSJAMNK> convert rfc822-to-8bit;
	Tue, 1 Oct 2002 08:13:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Garrett Kajmowicz <gkajmowi@tbaytel.net>
Reply-To: gkajmowi@tbaytel.net
Organization: Garrett Kajmowicz
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE, TRIVIAL, RFC] Linux source strip/bundle script
Date: Tue, 1 Oct 2002 08:14:17 -0400
User-Agent: KMail/1.4.1
References: <200210010734.14949.garrett@tbaytel.net> <3D998C95.9060606@corvil.com>
In-Reply-To: <3D998C95.9060606@corvil.com>
Cc: padraig.brady@corvil.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210010814.17353.gkajmowi@tbaytel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. When trashing the source like this you may as well remove
>     trailing whitespace (reduces kernel by 200K after compression).

	I do not modify the source code files themselves.  I simply 'prune' the tree, 
creating 'dummy' Config.in and Makefiles as requred to prevent things from 
breaking too much.  The only file that I edit in any way is the config.in in 
arch/i386 to change the scsi enabled default from y to n. This was so that 
people who don't download the scsi 'module' don't run into problems with 
compile failing.  I will be making a few patches to the source tree for the 
Config.in files to make this and other relted things less likely to happen.


> 3. What's the difference in size between 2.4.19.tar.bz2 and
>     2.4.19-bastardized.tar.bz2 ?

Size of some of the packages that I have done with this script:

linux-2.4.19-base.tar.bz2	-	11 MB
linux-2.4.19-scsi.tar.bz2	-	2.5 MB
There are currently 15 other 'modules', not listed here

> 4. Is this just for (a) removing redundant code after installation or
>     (b) providing subset version(s) for download.

This will provide a subset for download.  Due to not having the ability to 
host, it may be applied to the full code after download for testing purposes.

> 5. If 4(a) wouldn't you need to parse the .config to find the appropriate
>     bits to remove?

I prune the tree at the directory level.  If I do not want/need irda support, 
I wipe out the irda directory, recreate it with a dummy Makefile and 
Config.in file so the make menuconfig script doesn't break, and the kernel 
will compile.  This results in less savings, but in higher stability/ 
reliability.
