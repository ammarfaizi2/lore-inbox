Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271973AbRHVSb1>; Wed, 22 Aug 2001 14:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271975AbRHVSbR>; Wed, 22 Aug 2001 14:31:17 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:21261 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S271973AbRHVSbO>; Wed, 22 Aug 2001 14:31:14 -0400
Message-ID: <3B83FAC7.1B727294@t-online.de>
Date: Wed, 22 Aug 2001 20:32:39 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
In-Reply-To: <E15Zca4-0001z2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Try -ac Kernels with integrated PNPBIOS and "lspnp -v",
> > then you will see your "motherboard resources". No magic.
> 
> Except on the intel boards where your machine crashes, the vaio's where
> some queries corrupt memory, the boxes where an interrupt during a pnpbios
> call crashes the box, the machines where pnpbios called from both cpus at
> the same time is a crash case, the wonderful weird tiny races on some boxes
> that use smm traps and fail if random undefined things occur between the
> two out instructions...

So call it only once early on boot (in real mode) and save the table
for later use (we don't need the fancy features ...) ?

> > Alan, 2.4 would largely benefit from PNPBIOS, do you plan
> > to submit this to LT (probably with the proposed life saver fix) ?
> 
> Experience is that PnpBIOS services are so astoundingly buggy in many
> bioses that they are probably not worth the risk. Ie more boxes break by
> calling pnpbios than by assuming the vendor used a sane resource layout.

How are these bugs handled by Windows ?
Must we only mimick the Windows call layout to
enter bios-writer's well tested code path ?

> Before PnPBIOS can go mainstream we'd have to generate a detailed list
> of buggy bios signatures
