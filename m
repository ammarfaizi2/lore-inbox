Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbUCHNav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 08:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUCHNau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 08:30:50 -0500
Received: from av1-1-sn3.vrr.skanova.net ([81.228.9.105]:17865 "EHLO
	av1-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262377AbUCHNas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 08:30:48 -0500
Subject: Re: Strange DMA-errors and system hang with Promise 20268
From: Henrik Persson <nix@syndicalist.net>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c2dsha$psd$1@sea.gmane.org>
References: <1078602426.16591.8.camel@vega>  <c2dsha$psd$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1078752642.1239.14.camel@vega>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Mar 2004 14:30:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-03-07 at 02:05, Mario 'BitKoenig' Holbe wrote:
> Same here:
> 
> Mar  4 01:01:06 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> Mar  5 01:02:00 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> Mar  6 01:10:22 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> 
> Can you somehow correlate this to start of S.M.A.R.T selftests?

Nope. To this date I wasn't running anything of the sort. I ran a few
selftest now though.. Nothing happened..

> I suspect it having something to do with 2.4.25 new "One last
> read after the timeout" in ide-iops.c and accessing the drive
> while selftest running (possibly especially short selftest).
> Here, daily at 01:00 smartmontools runs smart short selftests
> and a bit later the machine hangs.
> Today, I disabled that job and the machine stays stable.

This happens every now and then.. Sometimes once a week or once a month.
Sometimes it's once per hour. I can't correlate this behaviour with any
activity that the box in question is doing (mysql, nfsd)..

> > error another device, but it's allways a device on the promise
> > controller, fails.
> 
> Dito... PDC20269 U133TX2
> CONFIG_BLK_DEV_PDC202XX_NEW=y
> 
> And until now it was always hde connected to the promise
> controller.
> 
> > I've seen this behaviour with 2.4.25, 2.4.24 and 2.4.23 (I think).
> 
> My machine did run at least since:
> Jan 18 09:41:21 darkside kernel: Linux version 2.4.24
> ...
> Feb 28 01:43:48 darkside kernel: Linux version 2.4.24
> Feb 28 04:58:47 darkside kernel: Linux version 2.4.25
> 
> First time the problem occured was Mar  4 01:01:06.

I've had those problems for at least a month. ;/

I just have no clue what's wrong with the damn thing.

-- 
Henrik Persson <nix@syndicalist.net>

