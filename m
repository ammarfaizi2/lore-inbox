Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130726AbRBSCmL>; Sun, 18 Feb 2001 21:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRBSCmC>; Sun, 18 Feb 2001 21:42:02 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:50439 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S130726AbRBSClu>;
	Sun, 18 Feb 2001 21:41:50 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Rainer Mager" <rmager@vgkk.co.jp>, <linux-kernel@vger.kernel.org>
Subject: RE: /proc/stat missing disk_io info
Date: Mon, 19 Feb 2001 11:40:42 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGIELEDBAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGGEBEDBAA.rmager@vgkk.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to be pushy or anything but since I received zero responses to this I
was wondering what else I can do. I'd be happy to patch the problem myself
but I have no idea what the correct value for DK_MAX_MAJOR  should be.

Anywho, if anyone has any thoughts I'd appreciate them.

--Rainer


> -----Original Message-----
> 	I was wondering why some of my disks don't show up in
> /proc/stat's disk_io
> line. Specifically, my line says:
>
> disk_io: (2,0):(144,144,288,0,0) (3,0):(35,35,140,0,0)
>
> This equates to my floppy and first cdrom. I also have a second cdrom (RW)
> and 2 hard disks. Looking at the code (kstat_read_proc in
> fs/proc/proc_misc.c) it is looping only up to DK_MAX_MAJOR which
> is defined
> as 16 in kernel_stat.h. The problem is that my 2 HDs have a major
> number of
> 22.
>
> I don't know enough to produce a patch, that is, what should
> DK_MAX_MAJOR be
> set to, but I believe the above is the problem.

