Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129354AbRBNWrP>; Wed, 14 Feb 2001 17:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129418AbRBNWrF>; Wed, 14 Feb 2001 17:47:05 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:61451 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129354AbRBNWrB>;
	Wed, 14 Feb 2001 17:47:01 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/stat missing disk_io info
Date: Thu, 15 Feb 2001 07:46:56 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGGEBEDBAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.30.0101242116520.30884-100000@cola.teststation.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	I was wondering why some of my disks don't show up in /proc/stat's disk_io
line. Specifically, my line says:

disk_io: (2,0):(144,144,288,0,0) (3,0):(35,35,140,0,0)

This equates to my floppy and first cdrom. I also have a second cdrom (RW)
and 2 hard disks. Looking at the code (kstat_read_proc in
fs/proc/proc_misc.c) it is looping only up to DK_MAX_MAJOR which is defined
as 16 in kernel_stat.h. The problem is that my 2 HDs have a major number of
22.

I don't know enough to produce a patch, that is, what should DK_MAX_MAJOR be
set to, but I believe the above is the problem.



Thanks,

--Rainer

