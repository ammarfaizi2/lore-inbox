Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287253AbSACMzB>; Thu, 3 Jan 2002 07:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287251AbSACMyv>; Thu, 3 Jan 2002 07:54:51 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13060 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287244AbSACMyk>;
	Thu, 3 Jan 2002 07:54:40 -0500
Date: Thu, 3 Jan 2002 10:54:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Peter Osterlund <petero2@telia.com>, lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler fixups ...
In-Reply-To: <Pine.LNX.4.40.0201021438500.1034-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33L.0201031053460.24031-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Davide Libenzi wrote:
> On 2 Jan 2002, Peter Osterlund wrote:
> > Davide Libenzi <davidel@xmailserver.org> writes:
> >
> > > a still lower ts
> >
> > This also lowers the effectiveness of nice values. In 2.5.2-pre6, if I
> > run two cpu hogs at nice values 0 and 19 respectively, the niced task
> > will get approximately 20% cpu time (on x86 with HZ=100) and this
> > patch will give even more cpu time to the niced task. Isn't 20% too
> > much?
>
> The problem is that with HZ == 100 you don't have enough granularity
> to correctly scale down nice time slices. Shorter time slices helps
> the interactive feel that's why i'm pushing for this.

So don't give the niced task a new timeslice each time,
but only once in a while.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

