Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288657AbSAIAwC>; Tue, 8 Jan 2002 19:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288660AbSAIAvx>; Tue, 8 Jan 2002 19:51:53 -0500
Received: from nile.gnat.com ([205.232.38.5]:18672 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288657AbSAIAvg>;
	Tue, 8 Jan 2002 19:51:36 -0500
From: dewar@gnat.com
To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020109005135.90321F2FFB@nile.gnat.com>
Date: Tue,  8 Jan 2002 19:51:35 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Hum, where in that standard does it say that the compiler won't
scribble all over memory?  If it doesn't, does that mean that within
the confines of the language standard that the compiler can?  If you
produce an Ada compiler that did, do you think your users would feel
better when you told them you were allowed to by the language
standard?
>>

YOu are appealing to the "intent" of the C standard to say that when
referencing volatile memory, ONLY the volatile variable can be
referenced and nothing else. OK, but where do you find this intent?
Or do we just have to take Mike's word for it? If so, that's not
very helpful (i.e. to consider that there is an implicit clause
in the standard that says to consult Mike to learn the intent of
anything not spelled out).

Seriously, I just don't see the requirement stated or implied in the
standard. Perhaps I am missing some language, that's certainly possible,
it is not a document that I know by heart beginning to end.

As to your question above, the external effects of an Ada program are very
carefully stated in the standard, and no one is allowed to try to extend
this set of effects by appealing to "intent". Of course marketing requirements
say many things, e.g. you can obviously compute A+B by recursive incrementing,
and of course that satisfies the standard, but it is obviously useless.

Now if you are claiming that generating efficient code to access a 16-bit
volatile quantity (by loading 32 bits) is in the same category, I absolutely
do not buy that at all.
