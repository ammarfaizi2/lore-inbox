Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269631AbRHCWAH>; Fri, 3 Aug 2001 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269632AbRHCV74>; Fri, 3 Aug 2001 17:59:56 -0400
Received: from smtp-server2.tampabay.rr.com ([65.32.1.39]:62939 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S269631AbRHCV7o>; Fri, 3 Aug 2001 17:59:44 -0400
Message-ID: <007801c11c67$87d55980$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: "Rik van Riel" <riel@conectiva.com.br>, "David Ford" <david@blue-labs.org>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108031751590.11893-100000@imladris.rielhome.conectiva>
Subject: Re: Ongoing 2.4 VM suckage
Date: Fri, 3 Aug 2001 17:59:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I floated this idea a while ago but didn't receive any comments (or
flames)...
Couldn't kswapd just gracefully back-off when it doesn't make any progress?
In my case (with ext3/raid5 and a tiobench test) kswapd NEVER actually swaps
anything out.
It just chews CPU time.
So...if kswapd just said "didn't make any progress...*2 last sleep" so it
would degrade itself.
Doesn't sound like a major rewrite to me.

----- Original Message -----
From: "Rik van Riel" <riel@conectiva.com.br>
To: "David Ford" <david@blue-labs.org>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>; "Richard B. Johnson"
<root@chaos.analogic.com>; <linux-kernel@vger.kernel.org>
Sent: Friday, August 03, 2001 4:53 PM
Subject: Re: Ongoing 2.4 VM suckage


> On Fri, 3 Aug 2001, David Ford wrote:
>
> > If it is that badly broken, isn't that sufficient criteria to justify
> > the patch?
>
> It's not just a patch. Fixing this problem will require
> a major VM rewrite. A rewrite I really wasn't willing
> to make for 2.4.
>
> I'll start writing the thing, but I won't be aiming at
> getting it included in 2.4. I guess I could code it in
> such a way to give a drop-in replacement for people
> willing to cut themselves on the bleeding edge, though ;)
>
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> http://www.surriel.com/ http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

