Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSKCTuQ>; Sun, 3 Nov 2002 14:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262641AbSKCTuQ>; Sun, 3 Nov 2002 14:50:16 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19216 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262486AbSKCTuP>; Sun, 3 Nov 2002 14:50:15 -0500
Message-Id: <200211031951.gA3JpBp29205@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jens Axboe <axboe@suse.de>, Brian Gerst <bgerst@didntduck.org>
Subject: Re: Machine's high load when HIGHMEM is enabled
Date: Sun, 3 Nov 2002 22:43:08 -0200
X-Mailer: KMail [version 1.3.2]
Cc: vasya vasyaev <vasya197@yahoo.com>, linux-kernel@vger.kernel.org
References: <20021103141753.50480.qmail@web20503.mail.yahoo.com> <3DC5337C.4090506@quark.didntduck.org> <20021103150041.GM807@suse.de>
In-Reply-To: <20021103150041.GM807@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 November 2002 13:00, Jens Axboe wrote:
> On Sun, Nov 03 2002, Brian Gerst wrote:
> > vasya vasyaev wrote:
> > >Hello,
> > >
> > >I have some strange kind of problem:
> > >When HIGHMEM-enabled kernel is used, there is too high
> > >CPU load on any task - computer get loaded high while
> > >it is doing some minor, usual jobs (load average grows
> > >significantly).
> >
> > 2.4 can only do I/O to and from lowmem.  This means highmem pages
> > have
>
> 2.4.19 and below, 2.4.20-pre/rc can dma to/from highmem pages just
> fine.
>
> > to use bounce buffers in lowmem, and th edata is copied to/from
> > highmem which is causing the cpu load.  This has been corrected in
> > 2.5, which can do I/O to any page the device can DMA from.
>
> I seriously doubt this is his problem, sounds like something else.
> For gzip to be disk bound (and thus bounce bound) you would need a
> seriously fast cpu. And the ssh problem cannot be explained by
> bouncing either.

bad mtrr?
--
vda
