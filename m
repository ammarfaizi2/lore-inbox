Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSJ1LBu>; Mon, 28 Oct 2002 06:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSJ1LBu>; Mon, 28 Oct 2002 06:01:50 -0500
Received: from ns.suse.de ([213.95.15.193]:17417 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263279AbSJ1LBs>;
	Mon, 28 Oct 2002 06:01:48 -0500
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: eggert@twinsun.com, linux-kernel@vger.kernel.org
Subject: Re: nanosecond file timestamp resolution in filesystems, GNU make, etc.
References: <20021027153651.GB26297@pimlott.net.suse.lists.linux.kernel> <200210280947.g9S9l9H01162@sic.twinsun.com.suse.lists.linux.kernel> <20021028102809.GA16062@bjl1.asuk.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2002 12:08:07 +0100
In-Reply-To: Jamie Lokier's message of "28 Oct 2002 11:36:02 +0100"
Message-ID: <p73r8eastwo.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

> Unfortunately that application code breaks when the filesystem may
> have timestamps with resolution better than 1 second, but worse than 1
> nanosecond. 

The current resolution is jiffies, which tends to be 1ms

 Then the application just can't do the right thing,
> unless it knows what rounding was applied by the kernel/filesystem, so
> it can change that rounding in a safe direction.

The rounding is always truncation. So the application can just assume
that.

-Andi
