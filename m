Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSAFNQ5>; Sun, 6 Jan 2002 08:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288867AbSAFNQr>; Sun, 6 Jan 2002 08:16:47 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:58029 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288859AbSAFNQf>;
	Sun, 6 Jan 2002 08:16:35 -0500
From: dewar@gnat.com
To: paulus@samba.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Cc: dewar@gnat.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org
Message-Id: <20020106131635.1177AF2FF5@nile.gnat.com>
Date: Sun,  6 Jan 2002 08:16:35 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Number of people suggested using assembly for this, why you keep
ignoring it and insist instead on changing the compiler, changing the
C standard, switching to another compiler and similar unproductive
ideas put forward solely for the sake of argument ?
>>

Maybe people will jump on me for saying this, but one objection I have to
using assembly is that the assembly language feature on gcc seems

a) awfully complicated, requiring more detailed knowledge of how the compiler
works than most programmers have.

b) certainly more complicated than comparable features in other compilers,
e.g. Borland C.

c) not that well documented

We find in the Ada world (where we have duplicated the C assembly language
feature more or less 100% exactly), that our customers almost always have to
ask us for help in getting asm inserts correct.

The GNU-C feature here is very powerful, but really not very easy to use!

I also find that introducing asm for this purpose is unnecessarily non-portable.
Yes in some cases, we are talking about very target specific code, but in other
cases the code is not so target specific, and it is desirable to stay within
C if possible.
