Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSAPUEG>; Wed, 16 Jan 2002 15:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287371AbSAPUD4>; Wed, 16 Jan 2002 15:03:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53771 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287368AbSAPUDt>; Wed, 16 Jan 2002 15:03:49 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hex addresses in setup.S
Date: 16 Jan 2002 12:03:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a24ma4$4ps$1@cesium.transmeta.com>
In-Reply-To: <BJEJJDPJOCEPDBLPFDKJCEACCCAA.ceswiedler@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <BJEJJDPJOCEPDBLPFDKJCEACCCAA.ceswiedler@mindspring.com>
By author:    "Chris Swiedler" <ceswiedler@mindspring.com>
In newsgroup: linux.dev.kernel
>
> Why does setup.S define the default system load address as 0x1000, and the
> comment on the line explain this to be 0x10000(and gives the decimal
> translation of 65536, so it's not a typo)? This seems to be true for several
> addresss (0x9000 = 0x90000, etc). I'm sure there's something simple I'm
> missing...what is it?
> 

In real mode:

linear_address := (segment << 4) + offset

Those addresses are "segment" addresses, with (implied) offset == 0.
These kinds of addresses are sometimes referred to as "paragraph
addresses" (paragraph being bigger than words but smaller than pages,
I guess.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
