Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273826AbRIRERe>; Tue, 18 Sep 2001 00:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273829AbRIRERO>; Tue, 18 Sep 2001 00:17:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64520 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273826AbRIRERK>; Tue, 18 Sep 2001 00:17:10 -0400
Date: Mon, 17 Sep 2001 23:53:10 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010918055823.S698@athlon.random>
Message-ID: <Pine.LNX.4.21.0109172339040.7032-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Sep 2001, Andrea Arcangeli wrote:

> On Mon, Sep 17, 2001 at 11:25:09PM -0300, Marcelo Tosatti wrote:
> > My point is: we're not going to start aging pte's until we have a
> > zone shortage, right ?
> 
> correct, so we don't waste time if there's only filesystem cache
> pressure during the whole kernel uptime (not an unlikely scenario if you
> have enough ram like on servers).
> 
> > I really think this will cause problems in practice, Andrea.
> 
> yes, this hiding could infact explain the report you posted. I'll try to
> reproduce with highmem emulation and to fix it as soon as I can
> reproduce, also if you are interested to hack on it too feel free to
> send patches of course. thanks.

Andrea,

Personally I think it is too late in the 2.4.x series to integrate your
code.

I have nothing against the code itself (the "old" code also had bugs), but
a major VM rewrite at this point seems to be dangerous if we want a stable
VM.

Don't you agree that your code can introduce new stability bugs ?

Linus, please, if you want to integrate Andrea's code do it in 2.5.x, but
not 2.4.x. (yes, I'm expecting you to scream at me now :))

