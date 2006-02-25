Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWBYPqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWBYPqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWBYPqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:46:33 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:56954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161014AbWBYPqd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:46:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gqEugOMOhaUtkbLvHNmC2biJIiHfWXDrx7SbYjAKAHvVBm0UnEpE0GXm9C+JUs8Mi1gH6YyfYQemrYukEKH8ECLSh54AIcA+2xTInPfQEIo1h4sRuG0VOM1E/KixJ4OoUKWvreQ0Lc5gKYSUtKqt/ll64lMvpigwVZtrflBnSOk=
Message-ID: <9a8748490602250746m30745f30sfe989ff4b2a1ecf2@mail.gmail.com>
Date: Sat, 25 Feb 2006 16:46:30 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: kernel BUG at fs/locks.c:1932!
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Fermin Molina" <fermin@asic.udl.es>, linux-kernel@vger.kernel.org
In-Reply-To: <20060225153525.GT3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140189359.22719.51.camel@viagra.udl.net>
	 <1140373675.7883.45.camel@lade.trondhjem.org>
	 <20060225153525.GT3674@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sun, Feb 19, 2006 at 01:27:55PM -0500, Trond Myklebust wrote:
> > On Fri, 2006-02-17 at 16:15 +0100, Fermin Molina wrote:
> > > Hi,
> > >
> > > I run samba sharing NFS mounted shares from another machine. I'm getting
> > > the following bugs in console (and in logs), when I stop samba (but not
> > > always, I think it depends of stalled locks):
> > >
> > > lockd: unexpected unlock status: 7
> > > lockd: unexpected unlock status: 7
> > > lockd: unexpected unlock status: 7
> > > ------------[ cut here ]------------
> >
> > Hmm... The problem here is that the server is returning an unexpected
> > error: it is normally supposed to return "lock granted" or "grace
> > error", but is actually returning "stale filehandle".
> >
> > Anyhow, the client should be able to deal with this without Oopsing.
>
>
> This seems to be a patch that should go into 2.6.16?
>
I'd agree and suggest that it also be send to -stable since it fixes a
crash actually seen "in the wild".

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
