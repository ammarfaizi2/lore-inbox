Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274516AbRITOUu>; Thu, 20 Sep 2001 10:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274510AbRITOUk>; Thu, 20 Sep 2001 10:20:40 -0400
Received: from ns.ithnet.com ([217.64.64.10]:64017 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S274511AbRITOUd>;
	Thu, 20 Sep 2001 10:20:33 -0400
Date: Thu, 20 Sep 2001 16:20:54 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: [PATCH] fix page aging (2.4.9-ac12)
Message-Id: <20010920162054.5f430fd4.skraw@ithnet.com>
In-Reply-To: <20010920170349.E22640@niksula.cs.hut.fi>
In-Reply-To: <20010920154806.75d7da23.skraw@ithnet.com>
	<20010920170349.E22640@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Sep 2001 17:03:49 +0300 Ville Herva <vherva@niksula.hut.fi> wrote:

> age - PAGE_AGE_DECL may be a 2^32-1 or so, but when you cast it back to int,
> it is at most 2^31 again. It rolls over, so you get the sign bit back.
> Witness:
> 
> vherva@linux:/home/vherva>cat n.c
> #define FOUR 4
> void main()
> {
>    unsigned three = 3;
>    printf("%u\n", three - FOUR);
>    printf("%i\n", (int)(three - FOUR));
>    printf("%i\n", (int)three - (int)FOUR);
> }
> 
> vherva@linux:/home/vherva>./a.out
> 4294967295
> -1
> -1
> 
> Perhaps a lucky incidence, but it works as Daniel wrote it. (At least on
> 32-bit architecture.)

Aha, you name it, and how do you find these goodies when moving the kernel over
to some new hardware platform? Even wrong things have long lives (see communist
block), nevertheless fate sometimes strikes back...

Regards,
Stephan


