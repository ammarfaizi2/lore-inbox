Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283287AbRLWDuU>; Sat, 22 Dec 2001 22:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283288AbRLWDuK>; Sat, 22 Dec 2001 22:50:10 -0500
Received: from mail.apptechsys.com ([207.14.35.131]:51859 "HELO
	mail.apptechsys.com") by vger.kernel.org with SMTP
	id <S283287AbRLWDt6>; Sat, 22 Dec 2001 22:49:58 -0500
Date: Sat, 22 Dec 2001 19:49:55 -0800 (PST)
From: Jeremy Drake <jeremyd@apptechsys.com>
To: <linux-kernel@vger.kernel.org>
Subject: Undefined symbol in nfsd.o kernel 2.4.17
Message-ID: <Pine.LNX.4.33L2.0112221937190.21842-100000@eiger.apptechsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting an undefined symbol in nfsd.o in kernel 2.4.17.  The message
is "/lib/modules/2.4.17/kernel/fs/nfsd/nfsd.o: unresolved symbol
nfsd_linkage".  Nfsd works fine when linked into the kernel.

Here's the NFS related section of my config:
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y

I was able to make it work by changing "EXPORT_SYMBOL(nfsd_linkage);" in
fs/filesystems.c to "EXPORT_SYMBOL_NOVERS(nfsd_linkage);".  Not sure if
that's the proper way to go about it, but it works :)

Please cc me on replies to this, because I haven't subscribed to the list.

Thanks,
Jeremy Drake

-- 
There are only two things in this world that I am sure of, death and
taxes, and we just might do something about death one of these days.
		-- shades

