Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319319AbSHOBYo>; Wed, 14 Aug 2002 21:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319329AbSHOBYo>; Wed, 14 Aug 2002 21:24:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54020 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319319AbSHOBYU>; Wed, 14 Aug 2002 21:24:20 -0400
Message-ID: <3D5B03A5.5050703@zytor.com>
Date: Wed, 14 Aug 2002 18:28:05 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Willy Tarreau <willy@w.ods.org>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <3D56B13A.D3F741D1@zip.com.au>	<Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de>	<ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl>	<3D5AB250.3070104@zytor.com> <20020814204556.GA7440@alpha.home.local> 	<3D5AC481.2080505@zytor.com> <1029374634.28240.26.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2002-08-14 at 21:58, H. Peter Anvin wrote:
> 
>>Since some processors now have "busy wait delay" instructions, this
>>would also make it possible to do:
> 
> 
> Nobody should be using an empty busy loop. If its a short timed busy
> loop then they should be using udelay, if its a long one
> schedule_timeout()
> 

Indeed.

> If its polling hardware then it isnt an empty loop

True indeed as well, although we should still have a busy_wait(); macro
that can insert whatever hint instruction the architecture might or
might not have.

	-hpa


