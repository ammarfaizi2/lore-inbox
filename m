Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135323AbREITQ7>; Wed, 9 May 2001 15:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbREITQv>; Wed, 9 May 2001 15:16:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15118 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135266AbREITQn>; Wed, 9 May 2001 15:16:43 -0400
Date: Wed, 9 May 2001 14:38:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <15096.42935.213398.64003@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105091437130.13878-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 May 2001, David S. Miller wrote:

> 
> Marcelo Tosatti writes:
>  > Ok, this patch implements thet thing and also changes ext2+swap+shm
>  > writepage operations (so I could test the thing).
>  > 
>  > The performance is better with the patch on my restricted swapping tests.
> 
> Nice.  Now the only bit left is moving the referenced bit
> checking and/or state into writepage as well.  This is still
> part of the plan right?

Hum...

You want writepage() to check/clean the referenced bit and move the page
to the active list itself ?


 

