Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270674AbRHJW7K>; Fri, 10 Aug 2001 18:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270681AbRHJW6z>; Fri, 10 Aug 2001 18:58:55 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:35854 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270679AbRHJW6Q>; Fri, 10 Aug 2001 18:58:16 -0400
Date: Fri, 10 Aug 2001 15:58:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
In-Reply-To: <E15VL6x-0007Jm-00@gondolin.me.apana.org.au>
Message-ID: <Pine.LNX.4.33.0108101557180.1048-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Aug 2001, Herbert Xu wrote:
>
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > In article <20010810231906.A21435@bonzo.nirvana> you write:
>
> > You have to use the reboot() system call directly as root, with the
> > proper arguments to make it avoid doing even any sync. See
>
> >        man 2 reboot
>
> How do you do this when the process in the D state is holding the BKL?

If it's in D state, it will be sleeping, and will have released the BKL.

Besides, does the reboot system call actually get the BKL? I don't think
it should need it..

		Linus

