Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRJZDNm>; Thu, 25 Oct 2001 23:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277385AbRJZDNb>; Thu, 25 Oct 2001 23:13:31 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:24282 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S277380AbRJZDNT>;
	Thu, 25 Oct 2001 23:13:19 -0400
Date: Fri, 26 Oct 2001 05:13:46 +0200
From: David Weinehall <tao@acc.umu.se>
To: Robert Love <rml@tech9.net>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        "Michael F. Robbins" <compumike@compumike.com>,
        linux-kernel@vger.kernel.org
Subject: Re: SiS/Trident 4DWave sound driver oops
Message-ID: <20011026051346.J25701@khan.acc.umu.se>
In-Reply-To: <1004016263.1384.15.camel@tbird.robbins> <7ktjw58u.wl@nisaaru.dvs.cs.fujitsu.co.jp> <1004060759.11258.12.camel@phantasy> <6693w4ds.wl@nisaaru.dvs.cs.fujitsu.co.jp> <1004061741.11366.32.camel@phantasy> <g087jff1.wl@nisaaru.dvs.cs.fujitsu.co.jp> <1004064125.19937.5.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1004064125.19937.5.camel@phantasy>; from rml@tech9.net on Thu, Oct 25, 2001 at 10:42:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 10:42:04PM -0400, Robert Love wrote:
> On Thu, 2001-10-25 at 22:36, Tachino Nobuhiro wrote:
> >   No. {0, } is the last elemnet of ac97_codec_ids[] and that index is
> > ARRAY_SIZE(ac97_code_ids) - 1. So this element which should be used as
> > a loop terminator is used as a valid entry in for loop incorrectly. 
> > 
> > Please read ac97_codec.c
> 
> You are right; I apologize.

I think the way this is coded stinks anyway. the {0,} should be used
as a loop-terminator, not ARRAY_SIZE(blaha) - 1. Yes, using 0-termination
wastes space. But it's cleaner and in line with what most other code
does.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
