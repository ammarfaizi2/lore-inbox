Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbREMR4h>; Sun, 13 May 2001 13:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbREMR41>; Sun, 13 May 2001 13:56:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20754 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S263211AbREMR4H>;
	Sun, 13 May 2001 13:56:07 -0400
Date: Sun, 13 May 2001 14:55:54 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <15102.51701.679466.475230@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105131455090.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2001, David S. Miller wrote:
> Rik van Riel writes:
>  > On Tue, 8 May 2001, David S. Miller wrote:
>  > > Nice.  Now the only bit left is moving the referenced bit
>  > > checking and/or state into writepage as well.  This is still
>  > > part of the plan right?
>  > 
>  > Why the hell would we want this ?
> 
> Because if it's a dead swap page the referenced bit is meaningless
> and we should just kill off the page immediately.

Then I'd rather check this in a visible place in page_launder()
itself. Granted, this is a special case, but I don't think this
one is worth obfuscating the code for...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

