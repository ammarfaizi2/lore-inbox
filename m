Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131090AbRAFACc>; Fri, 5 Jan 2001 19:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAFACX>; Fri, 5 Jan 2001 19:02:23 -0500
Received: from graft.XCF.Berkeley.EDU ([128.32.45.176]:37394 "EHLO
	wilber.gimp.org") by vger.kernel.org with ESMTP id <S129675AbRAFACC>;
	Fri, 5 Jan 2001 19:02:02 -0500
Date: Fri, 5 Jan 2001 16:00:21 -0800
From: Joshua Uziel <uzi@uzix.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.4.0 on sparc64 build problems
Message-ID: <20010105160021.A18483@gimp.org>
In-Reply-To: <200101051721.f05HLaP21812@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101051721.f05HLaP21812@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Fri, Jan 05, 2001 at 02:21:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Horst von Brand <vonbrand@inf.utfsm.cl> [010105 09:24]:
> Sun Ultra 1, RH 6.2 + updates (+ local hacks)
> 
> Building modules:
> 
> In drivers/sbus/audio:
> 
>   amd7930.c:113: ../../isdn/hisax/foreign.h: No such file or directory
>   amd7930.c:1159: warning: function declaration isn't a prototype
>   amd7930.c: In function `amd7930_dxmit':
>   amd7930.c:1266: warning: assignment from incompatible pointer type
>   amd7930.c: In function `amd7930_drecv':
>   amd7930.c:1312: warning: assignment from incompatible pointer type
>   amd7930.c: At top level:
>   amd7930.c:1486: variable `amd7930_foreign_interface' has initializer but incomplete type
>   [Ad nauseam]
> 
>   dbri.c:67: ../../isdn/hisax/foreign.h: No such file or directory
>   [More or less the same junk as above]

I'm wondering why building those drivers are options at all on sparc64
since none of the sparc64 machines (that I know of) currently available
have anything other than the cs4231 or no audio support.

Basically, those two should be removed from the config options for
sparc64... and in the meantime, you should build without 'em. :)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
