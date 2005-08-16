Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVHPMhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVHPMhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 08:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHPMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 08:37:10 -0400
Received: from web26902.mail.ukl.yahoo.com ([217.146.176.91]:63928 "HELO
	web26902.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932686AbVHPMhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 08:37:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uRcq8d3FCasF8A5XNUmqPbcenOD2tfw9iExK2tshXrY5xZ0shqtGXlogq8qzOc4YUkhEm8ABZBNePrwLPM9ya+8pyYrlG+ZtX6dUVR5303xn/CeriI1CrDQy6Khd/izV6uKd5KBkgj0qbGpUqrSi0amdczd9xnVAcBLxtabINmE=  ;
Message-ID: <20050816123708.84443.qmail@web26902.mail.ukl.yahoo.com>
Date: Tue, 16 Aug 2005 14:37:07 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
To: linux-kernel@vger.kernel.org, Shaun Jackman <sjackman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you see grub saying "uncompressing kernel..." or whatever that says?
>
> Grub says...
>
> root (hd2,2)
>   Filesystem type is ext2fs, partition type 0x83
> kernel /boot/vmlinuz-2.6.12.4 root=/dev/md0 ro nodma
>   [Linux-bzImage, setup=0x1e00, size=0x1302ff]

  May I suggest to try a boot with Gujin bootloader, i.e. put
http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/g/gu/gujin/install-1.2.tar.gz/install/boot.144?extract=true
  on a floppy, or:
http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/g/gu/gujin/install-1.2.tar.gz/install/boot.bcd?extract=true
  on a bootable CDROM and try it?

  If it is a BIOS probing problem, or early decompression, you can get more
 information by making a DOS bootable floppy and run this executable:
http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/g/gu/gujin/standard-1.2.tar.gz/dbgload.exe?extract=true
 It will act as the previous bootloader but also save a file named DBG
 on the floppy where it will write the value of all BIOS parameters given
 to Linux.

  If even Gujin misbehaves on accessing the disks, try dbgdisk.exe instead
 of dbgload.exe to see what is unusual in your BIOS - if it is a BIOS
 problem at all.

  Cheers,
  Etienne.



	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
