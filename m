Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSEJP5P>; Fri, 10 May 2002 11:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316044AbSEJP5M>; Fri, 10 May 2002 11:57:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26637 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316043AbSEJP4E>; Fri, 10 May 2002 11:56:04 -0400
Date: Fri, 10 May 2002 08:55:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Lincoln Dale <ltd@cisco.com>
cc: Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14
  IDE 56)
In-Reply-To: <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com>
Message-ID: <Pine.LNX.4.44.0205100854370.2230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Lincoln Dale wrote:
>
> so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no
> O_DIRECT. anyone have any clues?

Yes.

O_DIRECT isn't doing any read-ahead.

For O_DIRECT to be a win, you need to make it asynchronous.

		Linus

