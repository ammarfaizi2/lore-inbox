Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSERLjI>; Sat, 18 May 2002 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSERLjI>; Sat, 18 May 2002 07:39:08 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:41775 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S312426AbSERLjH>; Sat, 18 May 2002 07:39:07 -0400
Message-Id: <200205181138.AWF97768@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: Marc-Christian Petersen <mcp@linux-systeme.de>
Subject: Re: [PATCH] fixing supermount for > 2.4.19pre4
Date: Sat, 18 May 2002 13:37:52 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205181226.03997.mcp@linux-systeme.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> your patch for supermount does not work. Now it's even not possible to list
> the content via ls -lsa /mnt ... Mount hangs, no access is made, nothing.

Is supermount compiled into kernel or as a module? What drive, what media did 
you mount, what command did you issue? 

I tested it with supermount compiled into the kernel and

# mount -t supermount -o dev=/dev/hdb none /mnt/cdrom
# ls -l /mnt/cdrom

and

# cd /mnt/cdrom
# ls -l

# cd
# umount /mnt/cdrom

and it works fine for me, patched against 2.4.19-pre8-jp12, and /dev/hdb is 
an ISO 9660 CDROM in my DVD drive. No "stale NFS handles", clean mount and 
unmount, and with "debug" option I can see it works as a charme.

ftpfs is fixed in the same way but I did not reboot yet. 

Jörg
