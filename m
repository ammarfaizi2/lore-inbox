Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130245AbQK0Kd3>; Mon, 27 Nov 2000 05:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130458AbQK0KdJ>; Mon, 27 Nov 2000 05:33:09 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:16915 "HELO
        hermine.idb.hist.no") by vger.kernel.org with SMTP
        id <S130245AbQK0KdF>; Mon, 27 Nov 2000 05:33:05 -0500
Message-ID: <3A223159.EFB73263@idb.hist.no>
Date: Mon, 27 Nov 2000 11:03:05 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> 
> On Sun, Nov 26, 2000 at 09:11:18AM +1100, Herbert Xu wrote:
> 
> > No information is lost.
> 
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

Seems to me few other people think that way, thats why it is so
har for them to get.  And thats why this style of coding isn't very
helpful either.  It may be a real help for you, but not for others
who merely get confused or irritated at the small but easy to eliminate
micro-bloat.

There are certainly people so used to the implicit zeroing that they
think of "static int a;" as a zero initialization as explicit as
anything, because that's the way the language works. And they will
take just as much care if the "a-using" code is modified to run twice.
The "=0" part don't make it clearer for them if it was clear already.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
