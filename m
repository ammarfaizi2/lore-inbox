Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310127AbSCKOc3>; Mon, 11 Mar 2002 09:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310124AbSCKOcT>; Mon, 11 Mar 2002 09:32:19 -0500
Received: from mail.scram.de ([195.226.127.117]:56045 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S310127AbSCKOcL>;
	Mon, 11 Mar 2002 09:32:11 -0500
Date: Mon, 11 Mar 2002 15:32:01 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Kurt Garloff <garloff@suse.de>, <linux-kernel@vger.kernel.org>,
        Jay Estabrook <Jay.Estabrook@compaq.com>,
        Richard Henderson <rth@twiddle.net>
Subject: Re: Busmaster DMA broken in 2.4.18 on Alpha
In-Reply-To: <20020311171058.A9038@jurassic.park.msu.ru>
Message-ID: <Pine.NEB.4.33.0203111524390.1745-100000@www2.scram.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

> No, the ability to address 32 bits is property of an ISA bridge, not
> of any particular ISA card or device. Most alphas do have 32-bit ISA DMA.

This is wrong for bus master DMA. tms380tr.c sets DMA_MODE_CASCADE and the
addressing is done by the ISA card. As the card only has 24bit, the DMA is
limited to 24 bits.

Your patch would only cause a machine check, but DMA still wouldn't work.

Cheers,
--jochen

