Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261420AbREMQfb>; Sun, 13 May 2001 12:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbREMQfV>; Sun, 13 May 2001 12:35:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47375 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261418AbREMQfH>;
	Sun, 13 May 2001 12:35:07 -0400
Date: Sun, 13 May 2001 13:34:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <15096.42935.213398.64003@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105131332050.5468-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, David S. Miller wrote:
> Marcelo Tosatti writes:
>  > Ok, this patch implements thet thing and also changes ext2+swap+shm
>  > writepage operations (so I could test the thing).
>  > 
>  > The performance is better with the patch on my restricted swapping tests.
> 
> Nice.  Now the only bit left is moving the referenced bit
> checking and/or state into writepage as well.  This is still
> part of the plan right?

Why the hell would we want this ?

If the page is referenced, it should be moved back to the
active list and should never be a candidate for writeout.

I'm very happy we got rid of the horribly intertwined VM
code in 2.2 and went to a more separated design in 2.4...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

