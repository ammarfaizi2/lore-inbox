Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314395AbSFCTgc>; Mon, 3 Jun 2002 15:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSFCTgb>; Mon, 3 Jun 2002 15:36:31 -0400
Received: from pD952AF1C.dip.t-dialin.net ([217.82.175.28]:51845 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314395AbSFCTg3>; Mon, 3 Jun 2002 15:36:29 -0400
Date: Mon, 3 Jun 2002 13:36:17 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>,
        "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Atomic operations
In-Reply-To: <Pine.LNX.3.95.1020603132526.893A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0206031335090.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 3 Jun 2002, Richard B. Johnson wrote:
> atomic_t test_and_set(int i, atomic_t *v)
> {
>     int ret;
> 
>     __asm__ __volatile__(LOCK "movl (%1), %ecx\n"
>                          LOCK "orl   %0,  (%1)\n" 
> 	: ecx (ret) 
> 	: "r" (i), "m" (v)
> 	: "ecx", "memory" );
> 
>     return (ret & i);
> }

I'm not an expert, but shouldn't "exc" be quoted here? I'm just 
wondering...

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

