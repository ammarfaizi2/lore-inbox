Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSDSVgY>; Fri, 19 Apr 2002 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313045AbSDSVgX>; Fri, 19 Apr 2002 17:36:23 -0400
Received: from terminus.zytor.com ([64.158.222.227]:62428 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S313038AbSDSVgU>; Fri, 19 Apr 2002 17:36:20 -0400
Message-ID: <2459.131.107.184.74.1019252157.squirrel@www.zytor.com>
Date: Fri, 19 Apr 2002 14:35:57 -0700 (PDT)
Subject: Re: SSE related security hole
From: "H. Peter Anvin" <hpa@zytor.com>
To: <andrea@suse.de>
In-Reply-To: <20020419230454.C1291@dualathlon.random>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <ak@suse.de>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <jh@suse.cz>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Ummm...last I knew, fxrstor is *expensive*.  The fninit/xor regs setup
>> is  likely *very* much faster.  Someone should check this before we
>> sacrifice  100 cycles needlessly or something.
>
> most probably yes, fxrestor needs to read ram, pxor also takes some
> icache and bytecode ram but it sounds like it will be faster.
>
> Maybe we could also interleave the pxor with the xorps, since they uses
> different parts of the cpu, Honza?
>

You almost certainly should.  The reason I suggested FXRSTOR is that it
would initialize the entire FPU, including any state that future
processors may add, thus reducing the likelihood of any funnies in the
future.



