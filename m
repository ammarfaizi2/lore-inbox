Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129210AbQKWU16>; Thu, 23 Nov 2000 15:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129219AbQKWU1s>; Thu, 23 Nov 2000 15:27:48 -0500
Received: from Cantor.suse.de ([194.112.123.193]:23571 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129210AbQKWU1f>;
        Thu, 23 Nov 2000 15:27:35 -0500
Date: Thu, 23 Nov 2000 20:57:31 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
Message-ID: <20001123205731.A26914@gruyere.muc.suse.de>
In-Reply-To: <20001123164436.A17631@gruyere.muc.suse.de> <Pine.LNX.4.10.10011230825380.7992-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011230825380.7992-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 23, 2000 at 08:59:46AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 08:59:46AM -0800, Linus Torvalds wrote:
> [ Btw, I noticed that one of my machines _does_ have gcc-2.95.2, so I can
>   look at the isofs code generation myself.  I don't see anything obvious,
>   and the code is hairy. The differences between 2.91.66 and 2.95.2 are
>   big enough that a plain "diff" doesn't show anything clear. Andi, what
>   does your test-case look like? ]

Just a variable width shift of long long with both arguments fetched
from deep indirection via pointers, and that all in a function with
register pressure (extracted from the XFS source, which does all kinds
of nasty things with long long) 

I am actually not sure if the normal kernel contains even a variable
width long long shift.

-Andi (who also sees some strange hangs in 2.4.0test11-pre, but more
suspects his own hacks. no fs corruption, but I do not run dbench normally) 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
