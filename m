Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSGGMzb>; Sun, 7 Jul 2002 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSGGMza>; Sun, 7 Jul 2002 08:55:30 -0400
Received: from 213-97-137-182.uc.nombres.ttd.es ([213.97.137.182]:6928 "HELO
	iceberg.activanet.net") by vger.kernel.org with SMTP
	id <S315928AbSGGMz3>; Sun, 7 Jul 2002 08:55:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Admin <kernel@cideweb.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ittle problems with /dev/sr0 with 2.4.19-rc1
Date: Sun, 7 Jul 2002 14:58:01 +0200
User-Agent: KMail/1.4.2
References: <3D2812F0.C3A4441D@sympatico.ca> <20020707101347.GA21065@codepoet.org>
In-Reply-To: <20020707101347.GA21065@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207071458.01519.kernel@cideweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Domingo 07 Julio 2002 12:13, Erik Andersen wrote:
> On Sun Jul 07, 2002 at 06:07:44AM -0400, Christian Robert wrote:
> > [root@X-home:/btemp] # md5sum /dev/sr0
> > md5sum: /dev/sr0: Input/output error         <- oups, it failed
> >
> > [root@X-home:/btemp] # dd if=/dev/sr0 | md5sum
> > dd: reading `/dev/sr0': Input/output error   <- failed here too
> > 13440+0 records in
> > 13440+0 records out
> > 5ec08b6fa7bf09741d1310e5baa800de  -          <- but md5sum is OK
>
> Looks like a read ahead bug to me...  Out of curiousity,
> did you use "-no-pad" with mkisofs?
>
>  -Erik
Hi, I get same error with /dev/hdc, when I try the same on /dev/sr0, box 
freeze, kernel 2.4.17-xfs

Jul  7 14:29:24 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:24 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:24 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331600
Jul  7 14:29:24 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:24 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:24 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331604
Jul  7 14:29:24 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:24 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:24 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331608
Jul  7 14:29:24 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:24 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:24 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331612
Jul  7 14:29:28 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:28 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:28 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331616
Jul  7 14:29:31 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:31 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:31 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331620
Jul  7 14:29:31 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:31 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:31 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331624
Jul  7 14:29:31 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:31 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:31 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331628
Jul  7 14:29:32 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:32 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:32 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331632
Jul  7 14:29:32 iceberg kernel: hdc: command error: status=0x51 { DriveReady 
SeekComplete Error }
Jul  7 14:29:32 iceberg kernel: hdc: command error: error=0x50
Jul  7 14:29:32 iceberg kernel: end_request: I/O error, dev 16:00 (hdc), 
sector 1331636

