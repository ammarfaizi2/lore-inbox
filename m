Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJJBim>; Tue, 9 Oct 2001 21:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRJJBic>; Tue, 9 Oct 2001 21:38:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59403 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273204AbRJJBiO>; Tue, 9 Oct 2001 21:38:14 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Re: Discrepancies between /proc/cpuinfo and Dave J's 
 x86info
Date: 9 Oct 2001 18:38:39 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9q08qv$v7$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0107111625410.1811-100000@Appserv.suse.de> <p05100361b77232f67994@[207.213.214.37]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p05100361b77232f67994@[207.213.214.37]>
By author:    Jonathan Lundell <jlundell@pobox.com>
In newsgroup: linux.dev.kernel
>
> At 4:28 PM +0200 2001-07-11, Dave Jones wrote:
> >On Wed, 11 Jul 2001, Hugh Dickins wrote:
> >
> >>  Am I paranoid?
> >
> >Probably :)
> >The Intel CPUs with PSN I've seen simply drop 1 level.
> >What other CPUs support this feature? ISTR Transmeta had it?
> >Do they behave the same?
> >
> >>   I feel nervous about "c->cpuid_level--" inferring
> >>  what we expect to happen to it, would prefer to check it (below).
> >>  +		c->cpuid_level = cpuid_eax(0);
> >
> >No biggie, either solution is fine with me.
> 
> HD's version has the advantage of not having to make assumptions 
> about how future CPUs might handle the level, and leaves open the 
> alternative possibility of leaving the level at 3 (or some future 4) 
> and just turning off the serial-number capability.
> 

cpuid_level-- is wrong on at least one existing processor (Crusoe),
which doesn't have CPUID level 2 and therefore goes from 3 to 1.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
