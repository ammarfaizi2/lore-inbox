Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130422AbQK0Sbr>; Mon, 27 Nov 2000 13:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130607AbQK0Sbi>; Mon, 27 Nov 2000 13:31:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4480 "EHLO
        chaos.analogic.com") by vger.kernel.org with ESMTP
        id <S130352AbQK0Sbf>; Mon, 27 Nov 2000 13:31:35 -0500
Date: Mon, 27 Nov 2000 13:01:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Andrew E. Mileski" <andrewm@netwinder.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <3A22978B.30E6A29A@netwinder.org>
Message-ID: <Pine.LNX.3.95.1001127130021.760A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Andrew E. Mileski wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Mon, 27 Nov 2000, Andrew E. Mileski wrote:
> > >
> > > Reminds me ... <linux/kernel.h> has a "#if DEBUG" statement that blows
> > > up if the debug code does something like "#define DEBUG(X...) printk(X...)".
> > > I came across this recently (think I was debugging PCI code ... not sure).
> > > Changing it to "#ifdef DEBUG" avoids problems.
> > >
> > > --
> > > Andrew E. Mileski - Software Engineer
> > > Rebel.com  http://www.rebel.com/
> > 
> > I find that the following works fine:
> > 
> > #ifdef DEBUG
> > #define DEB(f) f
> > #else
> > #define DEB(f)
> > #endif
> 
> Agreed, but that wasn't my point.  There is debug code in the current
> kernel that defines DEBUG to something non-numeric, which causes
> the compile to barf on kernel.h in some cases (try defining DEBUG in
> your Makefile).  Instances of the offending code (there are SEVERAL)
> and kernel.h should be fixed.
> 
> Try this from the top level:
>   grep -r DEBUG * | grep -v DEBUG_ | less

Yep. I now understand your point.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
