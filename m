Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSHRTYh>; Sun, 18 Aug 2002 15:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSHRTYc>; Sun, 18 Aug 2002 15:24:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16374 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315748AbSHRTYa>; Sun, 18 Aug 2002 15:24:30 -0400
Subject: Re: 2.4.18-rc3aa3: dma_intr: status=0x51 errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Shane <shane@zeke.yi.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1029697810.2904.15.camel@mars.goatskin.org>
References: <1029697810.2904.15.camel@mars.goatskin.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Aug 2002 20:28:23 +0100
Message-Id: <1029698903.16786.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 20:10, Shane wrote:
> I just tried running Cerberus for 15-20s and I got these errors in the
> logs. I do use the nasty binary drivers but I replicated the errors from
> a fresh boot without them ever being loaded. Can someone tell me what
> these errors mean? And are they dangerous? Are there some docs on these
> error codes such that I could translate them myself without having to
> bother you guys?


> Aug 18 14:50:50 mars kernel: hdg: dma_intr: status=0x51 { DriveReady
> SeekComplete Error }
> Aug 18 14:50:50 mars kernel: hdg: dma_intr: error=0x40 {
> UncorrectableError }, LBAsect=61193, sector=61192
> Aug 18 14:50:50 mars kernel: end_request: I/O error, dev 22:00 (hdg),
> sector 61192

Tbats the drive logging a bad block on logical sector 61192 (be careful
with the 512byte/1K conversions here when using bad blocks
)


