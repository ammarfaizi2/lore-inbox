Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316971AbSGHPW3>; Mon, 8 Jul 2002 11:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316974AbSGHPW2>; Mon, 8 Jul 2002 11:22:28 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:46035 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S316971AbSGHPW0>; Mon, 8 Jul 2002 11:22:26 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Bttv errors with onboard video.
Date: 8 Jul 2002 14:41:16 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnaij94c.evr.kraxel@bytesex.org>
References: <sd29642e.098@GroupWise>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1026139276 15356 127.0.0.1 (8 Jul 2002 14:41:16 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I read a post relating to something similar with the VIA chipset. I
>  suppose the "bttv0: irq: SCERR risc_count=1764e020" errors isn't the
>  problem for why mine isn't working but just another normal error. Any
>  idea on how to put the bttv module into a debug mode?

bogomips kraxel ~# modinfo bttv | grep debug
parm:        bttv_debug int, description "debug messages, default is 0 (no)"
parm:        irq_debug int, description "irq handler debug messages, default is 0 (no)"

That likely doesn't help you througth.  SCERR is a syncronisation error
of the DMA engine.  Most likely the bt878 chip has problems to do
PCI-PCI transfers to the onboard video chipset for some reason.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
