Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbTAJPZD>; Fri, 10 Jan 2003 10:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbTAJPZA>; Fri, 10 Jan 2003 10:25:00 -0500
Received: from ca-metz-1-236.abo.wanadoo.fr ([80.8.112.236]:785 "EHLO
	xiii.freealter.fr") by vger.kernel.org with ESMTP
	id <S265285AbTAJPYL>; Fri, 10 Jan 2003 10:24:11 -0500
Message-ID: <3E1EE7A3.1050401@freealter.com>
Date: Fri, 10 Jan 2003 16:32:51 +0100
From: Ludovic Drolez <ludovic.drolez@freealter.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BLKBSZSET still not working on 2.4.18 ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm trying to backup a partition on an IDE drive which has an odd number 
of sectors (204939). With a stock open/read you cannot access the last 
sector, and that why I tried the BLKBSZSET ioctl to set the basic read 
block size to 512 bytes. I verified the writen value with BLKBSZGET 
ioctl, but I still cannot read this last sector !

I've tried also this:
- FreeBSD : works but it don't want to port all my software to it
- raw devices: can't read the last sector:

# raw  /dev/raw1 /dev/hda2
# dd if=/dev/raw1 of=C bs=512
dd: reading `/dev/raw1': No such device or address
204938+0 records in
204938+0 records out


What can it do ? Wait for a patch in 2.5.xxx ?

TIA,

    Ludovic Drolez.

