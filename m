Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276844AbRJCCwy>; Tue, 2 Oct 2001 22:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276845AbRJCCwo>; Tue, 2 Oct 2001 22:52:44 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:2749 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S276844AbRJCCwg>;
	Tue, 2 Oct 2001 22:52:36 -0400
Date: Wed, 3 Oct 2001 04:52:57 +0200
From: David Weinehall <tao@acc.umu.se>
To: Robert Love <rml@tech9.net>
Cc: Christof Efkemann <efkemann@uni-bremen.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830 support for agpgart
Message-ID: <20011003045257.Q7800@khan.acc.umu.se>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de> <1001988137.2780.53.camel@phantasy> <20011002151051.488306ee.efkemann@uni-bremen.de> <1002066345.1003.66.camel@phantasy> <20011003021658.O7800@khan.acc.umu.se> <1002075650.1237.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1002075650.1237.2.camel@phantasy>; from rml@tech9.net on Tue, Oct 02, 2001 at 10:20:43PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 10:20:43PM -0400, Robert Love wrote:
> On Tue, 2001-10-02 at 20:16, David Weinehall wrote:
> > If the only differences between the different cards are the nr of
> > aperture-sizes and the status-register settings, why not have a struct
> > which contains all the valid cards, and use a scan-routine?!
> 
> I suppose we could, and this is a good idea -- although we'd be
> reapproaching the size of the current implementation which would be
> theoretically faster, too.

Afaik, speed is not really an issue (it's not like you're going to
notice a difference anyway, even if you had a struct with 100 different
adapters in it.) As for reapproaching the size of the current
implementation, the difference is that you get one single function that
you don't have to change. You just add one single line to the struct
for each adapter.

Clean design is a virtue ;-)

> There are only 3 possibilities right now (i830, i840, and everything
> else).
> 
> Hmm, maybe I will code this nonetheless...

It's your call.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
