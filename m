Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287596AbSBIVJP>; Sat, 9 Feb 2002 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287563AbSBIVJG>; Sat, 9 Feb 2002 16:09:06 -0500
Received: from [208.29.163.248] ([208.29.163.248]:21744 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S287658AbSBIVJB>; Sat, 9 Feb 2002 16:09:01 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Pau Aliagas <linuxnow@wanadoo.es>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Date: Sat, 9 Feb 2002 13:07:48 -0800 (PST)
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
In-Reply-To: <Pine.LNX.4.44.0202092152440.17916-100000@pau.intranet.ct>
Message-ID: <Pine.LNX.4.44.0202091305510.25220-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just set this up between a couple machines at work and one thing we
ended up doing to get it to work was to generate a key without a
passphrase on it to use for syncing, otherwise the ssh on the machine
inititing the connection wanted a password to start the connection. you
also need to do the stuff mentioned for the receiving end so that it
doesn't ask for a password.

David Lang


 On Sat, 9 Feb 2002, Pau Aliagas wrote:

> Date: Sat, 9 Feb 2002 21:57:50 +0100 (CET)
> From: Pau Aliagas <linuxnow@wanadoo.es>
> To: Larry McVoy <lm@bitmover.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in
>     -pre4)
>
> On Sat, 9 Feb 2002, Larry McVoy wrote:
>
> > This is my problem.  You could help if you could tell me what exactly
> > are the magic wands to wave such that you can ssh in without typing
> > a password.  I know about ssh-agent but that doesn't help for this,
> > I know that in certain cases ssh lets me in without anything.  I thought
> > there was some routine where you ssh-ed one way and then the other way
> > and it left enough state that it trusted you, does any ssh genuis out
> > there know what I'm talking about?  If I have this, I can set up the
> > cron job, I'm sure this is obvious and I'm just overlooking something
> > but I can't find it.
>
> Just get the .ssh/id_dsa.pub from the client you want to allow in without
> a password and copy it inside .ssh/authorized_keys2 in the server.
>
> ssh-agent is useful if you protect your keys with a password so that you
> don't have to retype the password to unblock you own key over and over.
> Nothing to do with accessing other sites.
>
> If you need any help just tell me.
> Pau
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
