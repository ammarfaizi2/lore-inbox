Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130560AbQK1Dxs>; Mon, 27 Nov 2000 22:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130685AbQK1Dxi>; Mon, 27 Nov 2000 22:53:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:54537 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S130560AbQK1Dxb>; Mon, 27 Nov 2000 22:53:31 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: KERNEL BUG: console not working in linux
Date: 27 Nov 2000 19:23:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vv8es$86d$1@cesium.transmeta.com>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <20001128023652.A9368@veritas.com> <8vv2fa$7n6$1@cesium.transmeta.com> <20001128041409.A9525@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001128041409.A9525@veritas.com>
By author:    Andries Brouwer <aeb@veritas.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Nov 27, 2000 at 05:40:58PM -0800, H. Peter Anvin wrote:
> 
> > > What about adding an additional
> > > 
> > > 	andb	$0xfe, %al
> > > 
> > > in front of the outb?
> 
> > Already in test12-pre1.
> 
> Ach, I see I am too slow - had not even seen -pre1 and now Linus
> already announces -pre2.
> 
> Anyway, I considered that this A20 stuff belonged to my docs on
> the keyboard controller, so added a page
> 
> 	http://www.win.tue.nl/~aeb/linux/kbd/A20.html
> 
> (written half an hour ago). Comments are welcome.
> 

One thing... the "thwarted by cache" comment probably isn't very
useful.  As far as I know the only machines which have the cache
problem are i386 boxen, but the i386 doesn't have WBINVD.  The i486
has a pin on the CPU for A20, which takes effect inside the L1 cache,
and so it shouldn't have any A20 cache issues.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
