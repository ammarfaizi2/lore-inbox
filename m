Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130340AbQK0VEX>; Mon, 27 Nov 2000 16:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130343AbQK0VEO>; Mon, 27 Nov 2000 16:04:14 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:46598 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S130340AbQK0VD6>;
        Mon, 27 Nov 2000 16:03:58 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011272033.eARKXgr497038@saturn.cs.uml.edu>
Subject: Re: [PATCH] removal of "static foo = 0"
To: aeb@veritas.com (Andries Brouwer)
Date: Mon, 27 Nov 2000 15:33:42 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001125234624.A7049@veritas.com> from "Andries Brouwer" at Nov 25, 2000 11:46:24 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer writes:

> Do I explain things so badly? Let me try again.
> The difference between
> 
>   static int a;
> 
> and
> 
>   static int a = 0;
> 
> is the " = 0". The compiler may well generate the same code,
> but I am not talking about the compiler. I am talking about
> the programmer. This " = 0" means (to me, the programmer)
> that the correctness of my program depends on this initialization.
> Its absense means (to me) that it does not matter what initial
> value the variable has.

It is too late to fix things now. It would have been good to
have the compiler put explicitly zeroed data in a segment that
isn't shared with non-zero or uninitialized data, so that the
uninitialized data could be set to 0xfff00fff to catch bugs.
It would take much effort over many years to make that work.

I'd rather see the compiler optimize for cache line use and
make use of small address offsets to load variables.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
