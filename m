Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUJBJO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUJBJO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUJBJO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:14:59 -0400
Received: from [193.29.205.125] ([193.29.205.125]:3819 "EHLO s1.conecto.pl")
	by vger.kernel.org with ESMTP id S267365AbUJBJO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:14:56 -0400
From: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Windows Logical Disk Manager error
Date: Sat, 2 Oct 2004 11:14:39 +0200
User-Agent: KMail/1.7
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <200409231254.12287@senat> <1096641835.17297.45.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.60.0410020041030.14363@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0410020041030.14363@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410021114.40621@senat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I should add an AFAIK here.  I am by no means familiar (enough) with EVMS,
> LVM1/2, and the kernel Device Mapper itself, to be able to tell if there
> isn't some clever way of making it work with existing drivers and tools...

Good news, when I did the following:

# dmsetup create test
0 54138987 linear /dev/sda1 0
54138987 40965687 linear /dev/sda3 0

# mount /dev/mapper/test /mnt/d
# ls /mnt/d

... it worked!
(the same with sda4 + sda2 volume, i've taken numbers from ldminfo output)

Maybe it's worth to update Documentation/filesystems/ntfs.txt :)

-- 
mg
