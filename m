Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272625AbRHaHoI>; Fri, 31 Aug 2001 03:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272626AbRHaHn7>; Fri, 31 Aug 2001 03:43:59 -0400
Received: from geos.coastside.net ([207.213.212.4]:2491 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S272625AbRHaHnt>; Fri, 31 Aug 2001 03:43:49 -0400
Mime-Version: 1.0
Message-Id: <p05100301b7b4f098f76c@[10.128.7.49]>
In-Reply-To: <200108310119.f7V1Jws18144@oboe.it.uc3m.es>
In-Reply-To: <200108310119.f7V1Jws18144@oboe.it.uc3m.es>
Date: Fri, 31 Aug 2001 00:43:52 -0700
To: ptb@it.uc3m.es, gordo@pincoya.com
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Cc: "linux kernel" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:19 AM +0200 2001-08-31, Peter T. Breuer wrote:
>?? I don't follow this at all. Typeof is deterministic, since the
>gcc computer program is deterministic. Typeof MUST return the type of
>the expression to which it applies.  All expressions in C have
>precisely computed types -I guess  what you are saying is that that
>the type of an expression may be context dependent, which I can easily
>imagine in a random computer language, but seriously doubt for C.
>C really does type calculations via narrowing :-o! Oh yeah!
>
>Show me an instance of an expression that two differnt types depending
>on context. I am prepared to be surprised, but dubious.

OK.

At 1:27 AM +0200 2001-08-31, Peter T. Breuer wrote:
>// standard good 'ol faithful version
>#define __MIN(x,y) ({\
>    typeof(x) _x = x; \
>    typeof(y) _y = y; \
>    _x < _y ? _x : _y ; \
>  })

How about typeof(__MIN(u, s)), given unsigned u, int s?
-- 
/Jonathan Lundell.
