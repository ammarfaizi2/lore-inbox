Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285096AbRLQMIb>; Mon, 17 Dec 2001 07:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285098AbRLQMIU>; Mon, 17 Dec 2001 07:08:20 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:4113 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S278660AbRLQMH7>; Mon, 17 Dec 2001 07:07:59 -0500
Date: Mon, 17 Dec 2001 12:06:30 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, Chris Wright <chris@wirex.com>,
        Linus Torvalds <torvalds@transmeta.com>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <20011217115344.C14112@dev.sportingbet.com>
Message-ID: <Pine.LNX.4.33.0112171205590.10824-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Sean Hunter wrote:

> > Hmm. Looking at killall5 source I see
> >
> > kill(-1, STOP);
> > for(each proc with p.sid!=my_sid) kill(proc, sig);
> > kill(-1, CONT);
> >
> > I guess STOP will stop killall5 too? Not good indeed.

> Couldn't it just do:
[..]
> ... in other words, block signals, do the killing, then unblock?

SIGSTOP and SIGKILL can't be blocked.

Matthew.

