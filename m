Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290445AbSAXWvD>; Thu, 24 Jan 2002 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290434AbSAXWuh>; Thu, 24 Jan 2002 17:50:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290442AbSAXWt1>; Thu, 24 Jan 2002 17:49:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Strange asm warning from bsetupt.s in 2.5.3-pre5
Date: 24 Jan 2002 14:49:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2q317$ln$1@cesium.transmeta.com>
In-Reply-To: <3C5082E3.C3A61B27@easynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C5082E3.C3A61B27@easynet.be>
By author:    Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
In newsgroup: linux.dev.kernel
>
> I've just finished to compile 2.5.3-pre5 and I noticed
> the following  strange warning from as(1):
> 	as -o bsetup.o bsetup.s
> 	bsetup.s: Assembler messages:
> 	bsetup.s:1180: Warning: Value 0x37ffffff truncated to 0x37ffffff.
> 					  ~~~~~~		  ~~~~~~
> 
> It's comming from the small change introduced in setup.S:
> 	ramdisk_max:  .long __MAXMEM-1        # (Header version 0x0203 or later)
> 
> 
> FYI as(1) version is:
> 	as --version
> 	GNU assembler 2.11.90.0.19
> 

Suggest reporting a bug to binutils-bug@gnu.org?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
