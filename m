Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136161AbREGOyj>; Mon, 7 May 2001 10:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136165AbREGOya>; Mon, 7 May 2001 10:54:30 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:41998 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S136161AbREGOyP>; Mon, 7 May 2001 10:54:15 -0400
Message-Id: <200105071452.f47Eq2jn008611@pincoya.inf.utfsm.cl>
To: "David S. Miller" <davem@redhat.com>
cc: Jonathan Morton <chromi@cyberspace.org>,
        BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: page_launder() bug 
In-Reply-To: Message from "David S. Miller" <davem@redhat.com> 
   of "Sun, 06 May 2001 21:55:26 MST." <15094.10942.592911.70443@pizda.ninka.net> 
Date: Mon, 07 May 2001 10:52:02 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> said:
> Jonathan Morton writes:
>  > >-			 page_count(page) == (1 + !!page->buffers));
>  > 
>  > Two inversions in a row?
> 
> It is the most straightforward way to make a '1' or '0'
> integer from the NULL state of a pointer.

IMVHO, it is clearer to write:

  page_count(page) == 1 + (page->buffers != NULL)

At least, the original poster wouldn't have wondered, and I wouldn't have
had to think a bit to find out what it meant... If gcc generates worse code
for this, it should be fixed.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
