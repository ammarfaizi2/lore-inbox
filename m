Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315375AbSFDSCO>; Tue, 4 Jun 2002 14:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSFDSCN>; Tue, 4 Jun 2002 14:02:13 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:44933 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315275AbSFDSCM>; Tue, 4 Jun 2002 14:02:12 -0400
Date: Tue, 4 Jun 2002 19:33:41 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Gerald Teschl <gerald.teschl@univie.ac.at>
Cc: linux-kernel@vger.kernel.org, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] opl3sa2 isapnp activation fix
In-Reply-To: <3CFCFA33.7020106@univie.ac.at>
Message-ID: <Pine.LNX.4.44.0206041909490.26634-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Gerald Teschl wrote:

> >>Oops, that won't work on isapnp since dma = dma2 = -1 at this stage, how 
> >>about;
> >>
> >>if ((dma != -1) && (dma2 != -1)) frob();
> >>
> I don't get what you mean? I tested this, if I do "modprobe opl3sa2 
> dma=1 dma2=3" it will activate
> the card with dma 1,3 (according to /proc/isapnp). However, my card will 
> not work with these values.

How about this, you check if the resource register reads 0 for the DMA 
value and you reassign it using the resource registers, that way you skip 
on using magic values.

Cheers,
	Zwane

-- 
http://function.linuxpower.ca
		





