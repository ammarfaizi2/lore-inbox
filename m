Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbREVUph>; Tue, 22 May 2001 16:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262809AbREVUp1>; Tue, 22 May 2001 16:45:27 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:11530 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S262808AbREVUpV>; Tue, 22 May 2001 16:45:21 -0400
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Cc: <pz@spylog.ru>, <fxian@fxian.jukie.net>
Subject: __alloc_pages: 0-order allocation failed on 2.4.5-pre3
Date: Tue, 22 May 2001 13:43:28 -0700
Message-ID: <NDBBKKONDOBLNCIOPCGHEEEOHCAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I searched the lkml for previous reports of this error, and I've found a few
questions asked, but no real answer given.  I'm not looking for a quick
answer, but this just seems to be an issue that hasn't been touched on much.
Any thoughts (and solutions) would be greatly appreciated.

I'm cc'ing this to previous thread starters and responders.  I got the
following errors streaming down my console after about 5 days uptime on
2.4.5-pre3.  I sent a previous message out regarding the same error on
2.4.3-ac13.  Others have reported this same problem on 2.4.4 and 2.4.3 (no
mention of series).

__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.
__alloc_pages: 0-order allocation failed.

The system was unresponsive, but sysrq worked for a short while until the
above errors kicked in again.

The system is rather minimal.  The kernel is compiled with SMP (two CPUs)
and a 4GB limit to take advantage of the 1GB memory in it.  The system has a
SCSI disk subsystem (Adaptec 2940 + 3 uw-scsi drives), a 3c905b nic, and a
cheap video card.

The workload it handles is ~120 Apache processes (~5MB/process) and ~20
mysql threads (256MB keycache + ~5MB/thread).

--
Vibol Hou

