Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUAXV1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbUAXV1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:27:24 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:51972 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261681AbUAXV1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:27:22 -0500
To: Thomas Svedberg <thsv@am.chalmers.se>
Cc: Andreas Happe <andreashappe@gmx.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [net/8139cp] still crashes my notebook
References: <slrnc104io.mp.andreashappe@flatline.ath.cx>
	<87vfn24kgn.fsf@devron.myhome.or.jp>
	<1074959508.13666.4.camel@Athlon1.hemma.se>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 25 Jan 2004 06:26:57 +0900
In-Reply-To: <1074959508.13666.4.camel@Athlon1.hemma.se>
Message-ID: <87brot3un2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Svedberg <thsv@am.chalmers.se> writes:

> fre 2004-01-23 klockan 18.56 skrev OGAWA Hirofumi:
> > Andreas Happe <andreashappe@gmx.net> writes:
> > 
> > > hi,
> > > 
> > > my notebook (hp/compaq nx7000) still crashes when using 8139cp (runs
> > > rock solid with 8139too driver). The computer just locks up, there is no
> > > dmesg output. This has happened since I've got this laptop (around
> > > november '03).
> > 
> > It seems 8139cp.c has the race condition of rx_poll and interrupt.
> > Does the following patch fix this problem?
> > 
> > NOTE, since I don't have this device, patch is untested. Sorry.
> 
> I can confirm that this patch fixes the same complete lockup I have had
> since 2.6.0-test4 or so, (See: "Hard lock with recent 2.6.0-test
> kernels").
> 
> Tested against 2.6.2-rc1-mm2 which locks har without patch and works
> great with it.

Thaks for testing.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
