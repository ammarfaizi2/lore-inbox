Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSHHSGW>; Thu, 8 Aug 2002 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSHHSGW>; Thu, 8 Aug 2002 14:06:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19210 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317263AbSHHSGV>; Thu, 8 Aug 2002 14:06:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: problems with 1gb ddr memory sticks on linux
Date: 8 Aug 2002 11:09:30 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aiuc4q$46j$1@cesium.transmeta.com>
References: <20020808160456.GI16225@weccusa.org> <1028828840.28883.43.camel@irongate.swansea.linux.org.uk> <20020808163952.GJ16225@weccusa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020808163952.GJ16225@weccusa.org>
By author:    "Bryan K. Walton" <thisisnotmyid@tds.net>
In newsgroup: linux.dev.kernel
>
> On Thu, Aug 08, 2002 at 06:47:20PM +0100, Alan Cox wrote:
> > 
> > Almost certainly a BIOS problem. What typically happens when you see
> > this is that the BIOS misconfigured the MTRR registers. Linux starts
> > from top of ram windows seems to start from bottom so the effect shows
> > strongly in Linux.
> > 
> > Can you post your /proc/mtrr file please
> > 
> Here you go . . .
> 
> Dimm slot 1 = 256MB DDR PC2100 and
> Dimm slot 2 = 1024MB DDR PC2100
> 
> and the /proc/mtrr shows:
> 
> casa:~# cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1 
> 

Your BIOS didn't mark the second memory chunk as cacheable, so you're
running it uncached.  No wonder it sucks.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
