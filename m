Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUIDR4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUIDR4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUIDRzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:55:19 -0400
Received: from the-village.bc.nu ([81.2.110.252]:56728 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265195AbUIDRzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:55:03 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mark_H_Johnson@raytheon.com, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>
In-Reply-To: <1094256256.6575.109.camel@krustophenia.net>
References: <OFACA329EE.63AC9924-ON86256F04.00556E19-86256F04.00556E29@raytheon.com>
	 <1094256256.6575.109.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094316731.10586.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 04 Sep 2004 17:52:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-04 at 01:04, Lee Revell wrote:
> This is looking more and more like a video driver problem:

Not really. The delay is too small and X is smarter than this. (except a
VIA case that only recently got squished).

> The video cards have a command FIFO that is written to via the PCI bus.
> They also have a status register, read via the PCI bus, which says
> whether the command FIFO is full or not. The hack is to not check
> whether the command FIFO is full before attempting to write to it, thus
> saving a PCI bus read.

On problem cards X defaults to polling the status FIFO. You can tell it
to be rude but you have to actively do so. Newer PCI 2.x specs also have
a thing or two to say on the subject

