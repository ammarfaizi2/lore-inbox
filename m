Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRKRUrz>; Sun, 18 Nov 2001 15:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKRUrq>; Sun, 18 Nov 2001 15:47:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59655 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278690AbRKRUrc>; Sun, 18 Nov 2001 15:47:32 -0500
Subject: Re: [PATCH] more than four ES1371 cards
To: alex.perry@ieee.org (Alex Perry)
Date: Sun, 18 Nov 2001 20:55:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E165YOD-0001Hn-00@p2.alex.fastwave.net> from "Alex Perry" at Nov 18, 2001 12:18:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E165YyL-0004Ib-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The standard es1371 card consumes two DSP devices per card,
> so that you cannot use more than four of them in a single PC chassis.
> This patch adds a configuration option to disable the second DSP output
> so that the OSS maximum of eight cards can be installed and used together.

If you want to sort that out please instead fix the driver to use one dsp
device and allocate the play only channel to O_RDONLY when possible and
the other channel to both. This is how we handle all the newer cards like
the SB Live with hundreds of channels
