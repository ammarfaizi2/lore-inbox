Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289062AbSBDQbf>; Mon, 4 Feb 2002 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289074AbSBDQbZ>; Mon, 4 Feb 2002 11:31:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289062AbSBDQbO>; Mon, 4 Feb 2002 11:31:14 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: UNDI/PXE for 2.4.x available?
Date: 4 Feb 2002 08:31:01 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3md05$ps3$1@cesium.transmeta.com>
In-Reply-To: <20020204154633.E2BC267F3@penelope.materna.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020204154633.E2BC267F3@penelope.materna.de>
By author:    Tobias Wollgam <tobias.wollgam@materna.de>
In newsgroup: linux.dev.kernel
>
> Hello,
> 
> is there a UNDI (Universal Network Driver Interface, a part of the 
> PXE-specification) for the 2.4x kernel available?
> 
> We found one from Intel in its linux-pxe-sdk for the 2.2.x kernel. This 
> one works, but not with all pxe-networkcards.
> 

I think you'll have that problem with any UNDI driver; in either case
I suspect that (a) performance will stink no matter what and (b) it
won't work properly with SMP unless you apply really heavy locking.

The PXE people at Intel really seems enamored with the idea of using
the UNDI stack all the way into the operating system; I don't think
any sane operating system does that (DOS, of course, does, but DOS
isn't a sane operating system.)  If I'm not completely mistaken UNDI
was derived from NDIS 2 or so -- widely considered the crappiest of
all the various specifications for DOS drivers.

> Potentially we will port it from 2.2 to 2.4 or rewrite it for 2.4 with 
> a little assistance.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
