Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVHLSPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVHLSPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVHLSPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:15:40 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:46512 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750836AbVHLSP2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:15:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QogC8Mxv84n6W2zs/dZCmQaYsQOAYRvfCRyg+6/Ajs7eDtSDPvcBkNjwCwNqJKJp1/BbrP9pMgZJVwrnnnIPZKmIfY9q8qOHcwUsUZ2YAgW8LYTvOqx/y5dBSTqnJTSbCWVLYAbDwO63nLQK6EQIy7eV8VDFVSSx0vvyuV738RU=
Message-ID: <86802c4405081211153ec42f7e@mail.gmail.com>
Date: Fri, 12 Aug 2005 11:15:26 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: Atyfb questions and issues
Cc: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>,
       Jim Ramsay <jim.ramsay@gmail.com>, alex.kern@gmx.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0508121848040.30829@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
	 <Pine.LNX.4.56.0508121848040.30829@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james,

I remember that xlinit in 2.6 kernel only works when BIOS option-rom
really init fb.
It can not work if the BIOS option rom is not executed.

For 2.4, it reversed, it can not work if BIOS opton-rom is executed.
Only work if BIOS don't excute the option rom.

YH

On 8/12/05, James Simmons <jsimmons@infradead.org> wrote:
> 
> > > I have the following issue.  I am trying to get an ATI Rage XL chip
> > > working on a MIPS-based processor, with a 2.6.11-based kernel from
> > > linux-mips.org.  Now, I know that this was working with a 2.4.25-based
> > > kernel previously.
> >
> > Okay, the 2.4 driver is more intrusive, it programs the chip from start as
> > much as possible, while the 2.6 driver tries to depend on Bios settings. I
> > haven't checked out the 2.6 driver enough to see if it is still possible
> > to program from scratch.
> 
> The code is there to program the chip from scratch. Just select
> 
> "Rage XL No-BIOS Init support"
> 
> The last time I tried it it didn't work. If we could get it working that
> would be great.
> 
> > Yes, according to my register data sheet a 7 means the memory clock
> > frequency is derived from DLLCLK. Unfortunately I don't know what this
> > DLLCLK is. I think it means the chip isn't properly initialized yet and it
> > clocks the memory from a safe clock source to allow the computer to start.
> >
> > However, we most likely have no way to find out the speed of this DLLCLK.
> >
> > The memory clock frequency is important for the driver to be able to set a
> > display mode; it needs to program a memory reload frequency into the chip
> > which depends on the memory frequency.
> 
> Their is code in xlint.c that should properly set this. Have to debug that
> code.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
