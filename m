Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279722AbRKMWc0>; Tue, 13 Nov 2001 17:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279749AbRKMWcQ>; Tue, 13 Nov 2001 17:32:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15373 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279722AbRKMWcC>; Tue, 13 Nov 2001 17:32:02 -0500
Subject: Re: odd memory behaviour in 2.4.15
To: aamargulies@hotmail.com (Adam Margulies)
Date: Tue, 13 Nov 2001 22:39:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F191xWY5pCxlICSsiWd0000b164@hotmail.com> from "Adam Margulies" at Nov 13, 2001 12:39:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163mDR-0002Y6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a separate linux machine with identical hardware
> running 2.4.15 which also ran well, until I upgraded its
> memory to 4GB. Then it ran 3 times slower than with 1 GB of RAM.

We end up copying data around a lot more with the 4 or 64Gb kernels. Some of
this unneccessarily. It may be down to your workload it might be a vm
quirk. Do the boxes all run the same workload.

Jens Axboe has patches for some setups that basically kill the slowdown
for all cases providing your I/O controller is sane
