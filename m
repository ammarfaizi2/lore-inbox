Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbUCJLuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUCJLuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:50:20 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:48524 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S262193AbUCJLuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:50:16 -0500
Date: Wed, 10 Mar 2004 05:50:12 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Henrik Persson <nix@syndicalist.net>
cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
In-Reply-To: <1078752642.1239.14.camel@vega>
Message-ID: <Pine.GSO.4.21.0403100547430.8400-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Mar  4 01:01:06 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> > Mar  5 01:02:00 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> > Mar  6 01:10:22 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
> > 
> > Can you somehow correlate this to start of S.M.A.R.T selftests?
> 
> Nope. To this date I wasn't running anything of the sort. I ran a few
> selftest now though.. Nothing happened..
> 
> > I suspect it having something to do with 2.4.25 new "One last
> > read after the timeout" in ide-iops.c and accessing the drive
> > while selftest running (possibly especially short selftest).
> > Here, daily at 01:00 smartmontools runs smart short selftests
> > and a bit later the machine hangs.
> > Today, I disabled that job and the machine stays stable.

Does the disk's SMART error log (smartctl -l error) show any entries
related to this problem?  If so, please print them with the latest version
of smartmontools (5.30) which makes them more 'human readable" than
previous versions.

Bruce

