Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137121AbREKMZy>; Fri, 11 May 2001 08:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137122AbREKMZe>; Fri, 11 May 2001 08:25:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13185 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S137121AbREKMZW>; Fri, 11 May 2001 08:25:22 -0400
Date: Fri, 11 May 2001 08:25:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: Not a typewriter
In-Reply-To: <3AFB2DF2.C527048F@transmeta.com>
Message-ID: <Pine.LNX.3.95.1010511081314.6295A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001, H. Peter Anvin wrote:

> Wayne.Brown@altec.com wrote:
> > 
> > On 05/10/2001 at 05:38:32 PM hpa@transmeta.com (H. Peter Anvin) wrote:
> > 
> > >Sounds like someone has just clarified what the heck it means.  "tty"
> > >and "typewriter" aren't exactly the same thing (even though "tty"
> > >stands for "teletypewriter" it has come to mean something completely
> > >different in a Unix context)... "not a typewriter" is just a
> > >completely confusing error message for the uninitiated.
> > 
> > I disagree.  "Not a typewriter" is part of Unix tradition, and ought to be
> > retained as a historical reference.  It's also an opportunity for "the
> > uninitiated" to learn a little more and move a little closer to becoming "the
> > initiated."
> > 
> 
> Nowhere else in Unix is a "tty" referred to as a "typewriter".  "Not a
> tty" is one thing; "Not a typewriter" is just plain misleading.
> 

I was told that "Not a typewriter" was a catch-all for a screw-up.
It was to advise that it wasn't a typewriter keyboard you were
hacking at, where you could enter anything.

Over the years, I have used ENOTTY as a temporary return-code from
drivers and library procedures so I could tell what procedure
was returning an error. For instance, if you have a number of
calls that return ETIME, during testing it would be nice to see
what routine timed out. I was quite surprised to find out that
perror() was printing an error string that none of my procedures
were thought to have generated. Then I wrote:

#include <stdio.h>
#include <errno.h>
main() {
    errno = ENOTTY;
    perror("");
}

So "Not a typewriter" has been depreciated (deprecated?). The text
in the header file probably should be changed to show this.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


