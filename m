Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSE2JLf>; Wed, 29 May 2002 05:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSE2JLf>; Wed, 29 May 2002 05:11:35 -0400
Received: from [212.176.239.134] ([212.176.239.134]:9094 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S314602AbSE2JLe>; Wed, 29 May 2002 05:11:34 -0400
Message-ID: <000901c206f0$cfd42620$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8-ac5 ide & raid0 bugs
Date: Wed, 29 May 2002 13:11:26 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17CzUM-0000Qx-00*xW.sgZmpYmw* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wrote about ide problems with 2.4.19-pre8 a few days ago (it just trashed
filesystem in a couple hours) & I was told to try 2.4.19-pre8-ac5 it was a
little bit better though every 5-8 hours I've got ide errors in log (at
least it didn't crash my reiserfs volumes yet):
>-----------------------------
May 27 14:38:02 vzhik kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
May 27 14:38:02 vzhik kernel:
May 27 14:38:02 vzhik kernel: hdg: drive not ready for command
May 27 14:38:02 vzhik kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
May 27 14:38:02 vzhik kernel:
May 27 14:38:02 vzhik kernel: hdg: drive not ready for command
May 27 17:08:05 vzhik kernel: hdg: drive_cmd: status=0xd0 { Busy }
May 27 17:08:05 vzhik kernel:
May 27 17:08:05 vzhik kernel: hdg: status error: status=0x58 { DriveReady
SeekComplete DataRequest }
>-----------------------------
But now I've got even more bugs in log like:
>-----------------------------
May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 37713311 4
May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 37713343 4
May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 37713375 4
May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 37713407 2
May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 38161563 4
May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 38161595 4
May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 38161627 4
May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 38161659 4
May 29 11:28:07 vzhik kernel: raid0_make_request bug: can't convert block
across chunks or bigger than 16k 37713308 4
>-----------------------------

I don't even think about trying 2.4.19-pre9 since it doesn't has any ide
related issues in its changelist.
The question is -- What I have to try to get WORKING ide driver under
"STABLE" kernel?


