Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSEQMuG>; Fri, 17 May 2002 08:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316209AbSEQMuF>; Fri, 17 May 2002 08:50:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:63872 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316088AbSEQMuE>; Fri, 17 May 2002 08:50:04 -0400
Date: Fri, 17 May 2002 08:51:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "'Roger Luethi'" <rl@hellgate.ch>
cc: Shing Chuang <ShingChuang@via.com.tw>,
        Urban Widmark <urban@teststation.com>,
        "Ivan G." <ivangurdiev@linuxfreemail.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        AJ Jiang <AJJiang@via.com.tw>
Subject: Re: [PATCH] #2 VIA Rhine stalls: TxAbort handling
In-Reply-To: <20020517001534.GA3632@k3.hellgate.ch>
Message-ID: <Pine.LNX.3.95.1020517084216.4475A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, 'Roger Luethi' wrote:

> > I think one has to <somehow> find that the chip has halted besides
> > the current way (noticing that it can't transmit anymore). I don't
> 
> There seems to be a misunderstanding. We already get an interrupt and a
> status to indicate what kind of problem occured. Thanks to Shing's recent
> posting we even have confirmed information about what events stop the Tx
> engine. _Plus_ there is a bit flag TXON in a chip status register which
> indicates whether the Tx engine is active.
>
[SNIPPED...]
> 
> > In the chip-halted work-around that everybody seems to use now,
> > reprogram it from scratch. The last program operation being to remove
> > loop-back. I don't even know if this chip can be set to loop-back,
> > though, so the whole idea may be moot.
> 
> It can be set to loopback, but I'm not keen on having my chip reprogrammed
> by every traffic burst (excessive collisions -> abort). Is that really the
> fashion of the year now?

Well, maybe the fashion of the day. Do `grep karound *.c` in
../linux/drivers/net and see all the 'workarounds' that exist for
chip problems. Some of the problems are induced by the coding and
most are real hardware problems.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

