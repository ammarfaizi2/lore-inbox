Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288639AbSANCOe>; Sun, 13 Jan 2002 21:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288660AbSANCOZ>; Sun, 13 Jan 2002 21:14:25 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:58832 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288639AbSANCOL>; Sun, 13 Jan 2002 21:14:11 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 03:12:57 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114021417Z288639-13997+4537@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or just doing a large write while doing lots of reads... my personal
> nemesis is "mkisofs" for backups, which reads lots of small files and
> builds a CD image, which suddenly gets discovered by the kernel and
> written, seemingly in a monolythic chunk. I MAY be able to improve this
> with tuning the bdflush parameters, and I tried some tentative patches
> which didn't make a huge gain.
>
> I don't know if the solution lies in forcing write to start when a certain
> size of buffers are queued regardless of percentages, or in better
> scheduling of reads ahead of writes, or whatever.

Have you observed it with -rmap or -aa, too?
I bet, you have.

Try Andrew's read-latency.patch then.
I use it on top of O(1) and preempt all the time.
It should be one of the next 2.4.18-preX/2.4.19-preX patches.

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
