Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289324AbSAIKmk>; Wed, 9 Jan 2002 05:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289323AbSAIKma>; Wed, 9 Jan 2002 05:42:30 -0500
Received: from nile.gnat.com ([205.232.38.5]:51198 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289322AbSAIKmU>;
	Wed, 9 Jan 2002 05:42:20 -0500
From: dewar@gnat.com
To: bernd@gams.at, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
Message-Id: <20020109104220.8C688F3135@nile.gnat.com>
Date: Wed,  9 Jan 2002 05:42:20 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Especially if there are cases were this optimization yields a slower =

access (or even worse indirect bugs).
E.g. if the referenced "volatile short" is a hardware register and the
access is multiplexed over a slow 8 bit bus.  There are embedded systems
around where this is the case and the (cross-)compiler has no way to
know this (except it can be told by the programmer).
>>

Well that of course is a situation where the compiler is being deliberately
misinformed as to the relative costs of various machine instructions, and
that is definitely a problem. One can even imagine hardware (not such a hard
feat, one of our customers had such hardware) where a word access works, but
a byte access fails due to hardware shortcuts, 
