Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSE3MI0>; Thu, 30 May 2002 08:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSE3MIZ>; Thu, 30 May 2002 08:08:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1976 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316598AbSE3MIZ> convert rfc822-to-8bit;
	Thu, 30 May 2002 08:08:25 -0400
Date: Thu, 30 May 2002 04:52:58 -0700 (PDT)
Message-Id: <20020530.045258.126882990.davem@redhat.com>
To: pwaechtler@loewe-komp.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-pre8 fs/nfs/nfsroot.c - in_ntoa
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CF61542.6000500@loewe-komp.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Peter Wächtler <pwaechtler@loewe-komp.de>
   Date: Thu, 30 May 2002 14:04:18 +0200

   Somehow a call to in_ntoa went into the kernel.
   With that you can't linke the kernel, when CONFIG_ROOT_NFS=y
   is on.
   
   fs/fs.o: In function `root_nfs_getport':
   fs/fs.o(.text.init+0x10e1): undefined reference to `in_ntoa'
   make: *** [vmlinux] Fehler 1

No, in fact in_ntoa always had existed, except that I finally
killed it.  You're supposed to replace it with NIPQUAD not
the endian-unfriendly %x.

I've sent Marcelo fixes for this if someone else hasn't beaten
me to it already.
