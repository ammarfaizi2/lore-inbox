Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHRTK2>; Sun, 18 Aug 2002 15:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSHRTK2>; Sun, 18 Aug 2002 15:10:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:31761 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315709AbSHRTK2>; Sun, 18 Aug 2002 15:10:28 -0400
Message-Id: <200208181910.g7IJADp30225@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Ed Sweetman <safemode@speakeasy.net>, Alexander Viro <viro@math.psu.edu>
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
Date: Sun, 18 Aug 2002 22:06:53 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0208180509540.2495-100000@weyl.math.psu.edu> <1029662182.2970.23.camel@psuedomode> <1029694235.520.9.camel@psuedomode>
In-Reply-To: <1029694235.520.9.camel@psuedomode>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 August 2002 16:10, Ed Sweetman wrote:
> It appears i'm completely unable to not use devfs.  Attempting to run
> the kernel without mounting devfs results in it still being mounted or
> if not compiled in, locks up during boot.  Attempts to run the kernel
> and mv /dev does not work, umounting /dev does not work and rm'ing /dev
> does not work.  I cant create the non-devfs  nodes while devfs is
> mounted and i cant boot the kernel without devfs.  It seems that no
> uninstall procedure has been made and i've read the documentation that
> comes with the kernel about devfs and it says nothing about how to move
> back to the old device nodes from devfs.
>
> anyone have any suggestions?

Boot with devfs as usual.
Mount your root fs again, say

#mount /dev/hda2 /mnt/tmp

and you will see your /dev as it is on disk (i.e. without
devfs mounted over it) in /mnt/tmp/dev.
Now, mknod everything you need.

BTW, NFS mount over loopback (127.0.0.1) works too.
--
vda
