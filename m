Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269100AbRHBQQa>; Thu, 2 Aug 2001 12:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHBQQU>; Thu, 2 Aug 2001 12:16:20 -0400
Received: from www.transvirtual.com ([206.14.214.140]:24333 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S269039AbRHBQQO>; Thu, 2 Aug 2001 12:16:14 -0400
Date: Thu, 2 Aug 2001 09:15:56 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Patch in 2.2.18pre21 breaks fbcon logo
In-Reply-To: <20010728180801.A671@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.10.10108020912310.6354-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following patch that appeared in 2.2.18pre21 breaks the fbcon logo.
> Anyone knows what it was for?

Because con_switch for fbcon can change the video mode. set_palette often
depends on what the state of the graphics hardware is in. So set_palette
must come after the con_switch. Unfortunely the display logo code depended
on this flaw. It was fixed tho in the 2.4.X tree with new logo code. 

