Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278086AbRJVIdz>; Mon, 22 Oct 2001 04:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278281AbRJVIdq>; Mon, 22 Oct 2001 04:33:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278086AbRJVId3>; Mon, 22 Oct 2001 04:33:29 -0400
Subject: Re: [Dri-devel] my X-Kernel question
To: shurdeek@panorama.sth.ac.at (Peter Surda)
Date: Mon, 22 Oct 2001 09:39:37 +0100 (BST)
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20011022102459.X12359@shurdeek.cb.ac.at> from "Peter Surda" at Oct 22, 2001 10:24:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vacU-0001Cn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> we move the whole driver structure to kernel? Drivers for every other device

Not really. 

> STRUCTURE. For a great UI, we need DMA, vsync and devices communicating with
> each other directly or with little overhead. Why insist on doing this in

A video driver has to have extremely good latency, syscalls are overhead that
you generally do not want. There are specific things you want kernel help
with - agp management (and thus AGP DMA), context switching on DRI and maybe
some day interrupt handling for video vsync events and wiring them into
the XSync extension.

The rest is a bit questionable as a kernel space candidate, but if you 
want it in kernel go ahead - XFree86 supports both models. 
