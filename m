Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSHULSV>; Wed, 21 Aug 2002 07:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSHULSV>; Wed, 21 Aug 2002 07:18:21 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:47377 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318243AbSHULSV>; Wed, 21 Aug 2002 07:18:21 -0400
Date: Wed, 21 Aug 2002 13:22:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
In-Reply-To: <200208210401.g7L410F21464@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0208211248050.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Aug 2002, Richard Gooch wrote:

> > Optimization??? This would require any device had to be be opened
> > _only_ through devfs, you are not seriously suggesting that???
>
> Huh? Of course not! All I'm saying is that if you use devfs, the
> optimisation will short-circuit the lookups.

Duplicating code paths like this doesn't count as optimization. Optimize
the common case and not the special case, so everyone can benefit from it.
Code duplication like this lets devfs suck so much. Anytime something is
changed in this area, devfs most likely needs to be fixed too.

bye, Roman

