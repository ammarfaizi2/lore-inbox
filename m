Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSGPLnJ>; Tue, 16 Jul 2002 07:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSGPLnI>; Tue, 16 Jul 2002 07:43:08 -0400
Received: from daimi.au.dk ([130.225.16.1]:20154 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315806AbSGPLnG>;
	Tue, 16 Jul 2002 07:43:06 -0400
Message-ID: <3D340775.7F7AAFB9@daimi.au.dk>
Date: Tue, 16 Jul 2002 13:45:57 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac5
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DMA is still broken on the ALI15X3 IDE controller.
Does anybody know what the problem could be
? The
problem was introduced by this patch:

http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2

But it is a 700K patch, without knowing a little
more about what is going on I'd have a hard time
finding the problem in that patch.

Symptoms are:
- DMA does not get enabled at boot.
- Manually switching on DMA will cause all disk
  access to hang, the IDE led stays light until
  IDE is initialized at next boot.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
