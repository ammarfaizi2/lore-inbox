Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314637AbSEPTlo>; Thu, 16 May 2002 15:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314641AbSEPTln>; Thu, 16 May 2002 15:41:43 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:54586 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S314637AbSEPTlm>; Thu, 16 May 2002 15:41:42 -0400
Message-Id: <200205161941.AWE93399@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: Pozsar Balazs <pozsy@sch.bme.hu>
Subject: Re: [PATCHSET] 2.4.19-pre8-jp12
Date: Thu, 16 May 2002 21:39:14 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.GSO.4.30.0205160941040.956-100000@balu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But the worst problem for is supermount:
> # mount -t supermount -o dev=/dev/cdrom none /mnt/cdrom
> # ls -l /mnt/cdrom
> ls: .: Stale NFS handle                (~or something similar)
> [...]                                  (and it lists the file)
>
> But:
> # cd /mnt/cdrom
> # ls -l
> ls: .: Stale NFS handle
> #                                      (and it doesn't even list the files)

Hi Pozsar, this is a known supermount bug. I got this as well. Supermount is 
a patch for 2.4.18pre8 kernel, not for 2.4.19preX. See also

http://www.mandrake.com/en/archives/cooker/2002-04/msg00086.php

I will try my best to figure out what is happening. The open(".",...) call to 
supermount returns -1 and this gives "stale NFS handle", but 
open("/mnt/cdrom", ...) gives "3" or a positive number. I think the text of 
the message is misleading, it has nothing to do with NFS.

Jörg
