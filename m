Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288902AbSAXXKn>; Thu, 24 Jan 2002 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287183AbSAXXKe>; Thu, 24 Jan 2002 18:10:34 -0500
Received: from svr3.applink.net ([206.50.88.3]:41993 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S280126AbSAXXKS>;
	Thu, 24 Jan 2002 18:10:18 -0500
Message-Id: <200201242308.g0ON8HL06970@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Robert Love <rml@tech9.net>, timothy.covell@ashavan.org
Subject: Re: RFC: booleans and the kernel
Date: Fri, 25 Jan 2002 17:09:45 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Xavier Bestel <xavier.bestel@free.fr>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org> <200201242246.g0OMkML06890@home.ashavan.org.> <1011913193.810.26.camel@phantasy>
In-Reply-To: <1011913193.810.26.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 January 2002 16:59, Robert Love wrote:
> On Fri, 2002-01-25 at 17:47, Timothy Covell wrote:
> > > gcc already warns you about such errors.
> > >
> > > 	Xav
> >
> > That's funny, I compiled it with "gcc -Wall foo.c" and got no
> > warnings.    Please show me what I'm doing wrong and how
> > it's _my_ mistake and not the compilers.
>
> Hm, I recall seeing something like:
>
> warning: suggest parentheses around assignment used as truth value
>
> from gcc ... yep, I still do.
>
> 	Robert Love
>
My mistake, I was looking at the ouput of my "char x;" example,
which IMHO is even worse.

covell@xxxxxxx ~>cat foo.c

#include <stdio.h>

int main()
{
        char x;

        if ( x )
        {
                printf ("\n We got here\n");
        }
        else
        {
                // We never get here
                printf ("\n We never got here\n");
        }
        exit (0);
}
covell@xxxxxx ~>gcc -Wall foo.c
foo.c: In function `main':
foo.c:17: warning: implicit declaration of function `exit'

-- 
timothy.covell@ashavan.org.
