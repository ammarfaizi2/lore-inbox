Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVADWc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVADWc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVADWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 17:32:41 -0500
Received: from mlf.linux.rulez.org ([192.188.244.13]:28172 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S262123AbVADWYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 17:24:06 -0500
Date: Tue, 4 Jan 2005 23:24:00 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: tridge@samba.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Michael B Allen <mba2000@ioplex.com>,
       sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-NTFS-Dev] Re: FAT, NTFS, CIFS and DOS attributes
In-Reply-To: <16857.57572.25294.431752@samba.org>
Message-ID: <Pine.LNX.4.21.0501042312550.22795-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jan 2005 tridge@samba.org wrote:

> you need more than one byte for DOS attrib. These are the bits Samba4
> defines:
> 
> /* FileAttributes (search attributes) field */
 [ ... ]
> #define FILE_ATTRIBUTE_SPARSE		0x0200
 [ ... ]
> #define FILE_ATTRIBUTE_COMPRESSED	0x0800
 [ ... ] 
>
> while most apps don't care about the bits beyond 0xFF at the moment, I
> think that might change, especially for win32 clients accessing linux
> filesystems via wine and Samba.

Setting the above two attributes from a Linux client accessing NTFS via
cifsfs pops up more often too. One scenario would be

  ntfsclone --fs-compression --output /mnt/cifsfs/backup.img /dev/foo

and the transparently compressed backup.img should be loopback mountable
by whatever preferred NTFS driver for whatever reason.

	Szaka

