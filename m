Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277574AbRJHWgz>; Mon, 8 Oct 2001 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277572AbRJHWgq>; Mon, 8 Oct 2001 18:36:46 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:55011 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S277576AbRJHWge>; Mon, 8 Oct 2001 18:36:34 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Date: Mon, 8 Oct 2001 14:16:04 -0700 (PDT)
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.3.96.1011009001720.20446A-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.40.0110081414360.30206-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

only 4096 processes, sounds low to me (I realize that some of my configs
are not typical, but this isn't that unusual on servers)

does this limit go up if you raise the max number of processes/threads?

David Lang

On Tue, 9 Oct 2001, Mikulas Patocka wrote:

> Date: Tue, 9 Oct 2001 00:21:04 +0200 (CEST)
> From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Rik van Riel <riel@conectiva.com.br>,
>      Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
>      linux-kernel@vger.kernel.org
> Subject: Re: %u-order allocation failed
>
> On Sun, 7 Oct 2001, Alan Cox wrote:
>
> > > The difference between memory and vmalloc space is this: you fill up the
> > > whole memory with cache => memory fragments. You don't fill up the whole
> > > vmalloc space with anything => vmalloc space doesn't fragment.
> >
> > vmalloc space fragments. You fragment address space rather than pages thats
> > all. Same problem
>
> If you have more than half of virtual space free, you can always find two
> consecutive free pages. Period.
>
> You can fill up half of virtual space if you start 4096 processes or load
> many modules of total size 32M. Is it clear? Do you realize that no one
> will ever hit this limit in typical linux configuration?
>
> Mikulas
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
