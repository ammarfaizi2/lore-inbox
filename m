Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVAKMcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVAKMcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 07:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbVAKMcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 07:32:52 -0500
Received: from aun.it.uu.se ([130.238.12.36]:29845 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262732AbVAKMcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 07:32:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16867.51031.185106.150042@alkaid.it.uu.se>
Date: Tue, 11 Jan 2005 13:32:23 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, bernard@blackham.com.au,
       shawv@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Screwy clock after apm suspend
In-Reply-To: <20050111031931.GC4092@elf.ucw.cz>
References: <7bb8b8de05010710085ea81da9@mail.gmail.com>
	<20050109224711.GF1353@elf.ucw.cz>
	<200501092328.54092.shawv@comcast.net>
	<20050110074422.GA17710@mussel>
	<20050110105759.GM1353@elf.ucw.cz>
	<20050110174804.GC4641@blackham.com.au>
	<20050111001426.GF1444@elf.ucw.cz>
	<20050111141332.68e5e05b.sfr@canb.auug.org.au>
	<20050111031931.GC4092@elf.ucw.cz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > ...and arch/i386/kernel/time.c contains copy of that code. That means
 > that we should kill apm.c copy and see why time.c copy sometimes does
 > the wrong thing.

We already know the difference: apm.c only updates xtime, time.c
updates both xtime and jiffies.
