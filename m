Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289115AbSBJBPm>; Sat, 9 Feb 2002 20:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289138AbSBJBPb>; Sat, 9 Feb 2002 20:15:31 -0500
Received: from [208.29.163.248] ([208.29.163.248]:26025 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S289115AbSBJBPK>; Sat, 9 Feb 2002 20:15:10 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Date: Sat, 9 Feb 2002 17:14:00 -0800 (PST)
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus
  compile in -pre4))
In-Reply-To: <3C65C4C5.C287A3@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202091713180.25220-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

how does this work when running something from cron? (I think that's the
type of thing Larry is trying to do)

David Lang

On Sat, 9 Feb 2002, Jeff Garzik wrote:

> Date: Sat, 09 Feb 2002 19:54:29 -0500
> From: Jeff Garzik <jgarzik@mandrakesoft.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
> Subject: ssh primer (was Re: pull vs push (was Re: [bk patch] Make
>     cardbus  compile in -pre4))
>
> Herbert Xu wrote:
> >
> > Larry McVoy <lm@bitmover.com> wrote:
> >
> > > This is my problem.  You could help if you could tell me what exactly
> > > are the magic wands to wave such that you can ssh in without typing
> > > a password.  I know about ssh-agent but that doesn't help for this,
> >
> > Setup your key with an empty passphrase should do the trick.
>
> Ug.  no.  That is way way insecure.
>
> Most modern distros have an ssh-agent running as a parent of all
> X-spawned processed (including processes spawned by xterms).  So, one
> only needs to run
> 	ssh-add ~/.ssh/id_dsa ~/.ssh/identity
> once, and input your password once.  After that, no passwords are
> needed.
>
>
> For those with multiple peer shells and no X-parented ssh-agent, you
> will need to run ssh-agent ONCE, like so:
>
> 	ssh-agent > ~/tmp/ssh-agent.out
>
> and then for each shell, you need to run:
>
> 	eval `cat ~/tmp/ssh-agent.out`
>
> and then run the ssh-add command from above.
>
> --
> Jeff Garzik      | "I went through my candy like hot oatmeal
> Building 1024    |  through an internally-buttered weasel."
> MandrakeSoft     |             - goats.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
