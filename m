Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSHaOkM>; Sat, 31 Aug 2002 10:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSHaOkM>; Sat, 31 Aug 2002 10:40:12 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:46865 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id <S315472AbSHaOkL>; Sat, 31 Aug 2002 10:40:11 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200208311440.g7VEe6XD004888@wildsau.idv.uni.linz.at>
Subject: Re: 2.4.19, CONFIG_RAMFS=y
In-Reply-To: <200208311418.g7VEImGD004866@wildsau.idv.uni.linz.at> from "H.Rosmanith" at "Aug 31, 2 04:18:48 pm"
To: kernel@wildsau.idv.uni.linz.at (H.Rosmanith)
Date: Sat, 31 Aug 2002 16:40:06 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> hi,
> 
> in <linus/fs/Config.in>, RAMFS is defined y always. why not make it
> a tristate? the help says, that RAMFS is a programming example only,
> so there's no need to absolutely have it compiled in the kernel.

aha, okay. so ramfs/inode.c defines init_rootfs, which in fact *is*
absolutely needed by the kernel in fs/namespace.c

but then Configure.help is missleading, and RAMFS should not be a CONFIG_
option anyway.

  : Simple RAM-based file system support
  : CONFIG_RAMFS
  :   Ramfs is a file system which keeps all files in RAM. It allows
  :   read and write access.
  : 
  :   It is more of an programming example than a usable file system.
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

wrong.

regards,
herp
 
