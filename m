Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263745AbRGGARd>; Fri, 6 Jul 2001 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264072AbRGGARX>; Fri, 6 Jul 2001 20:17:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40708 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263745AbRGGARI>; Fri, 6 Jul 2001 20:17:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why Plan 9 C compilers don't have asm("")
Date: 6 Jul 2001 17:16:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9i5kdp$qvs$1@cesium.transmeta.com>
In-Reply-To: <200107061724.NAA14777@smarty.smart.net> <15174.20383.84051.790269@pizda.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15174.20383.84051.790269@pizda.ninka.net>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>
> Rick Hohensee writes:
>  > Forth chips aren't modern in the true-multi-user sense, but if an
>  > individual were to design such a beast they could get several of them,
>  > hundreds maybe, on FPGAs available now. Such things are coming, because a 
>  > Forth chip IS something an individual can design.
> 
> And I suppose this zero-cost call is also handling things like keeping
> an N stage deep pipeline full during this call right?
> 

Believe it or not, that's actually a fairly simple part of the whole
machinery.  All you need for that is to maintain a call/return stack
in the front end of the pipe.  That way, a return that is indeed a
return can be speculated properly; obviously, if the speculation
doesn't work out when you get the return address in the execution
stage you suffer a branch mispredict penalty.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
