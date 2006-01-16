Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWAPUz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWAPUz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWAPUz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:55:27 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:29913 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751199AbWAPUz0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:55:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UCDC9CG1Nrof2NufGBqXfasrsAnFx9hhoYjgjDANiPn6tB3rTLm4D8quMZzM/CNb8K9HFIJxm5WXy+/v4X2UsNx1RlLxT9PgLOXCo7Ai4/bOhEWvQCaWqEHZ5mx+spd7Ggj8ZH4PnieOXXxth9jZXiVURj6iKwp9USuVXCkz/SA=
Message-ID: <bdfc5d6e0601161255w4e1a6ac5oaa6844a6e1bbd0aa@mail.gmail.com>
Date: Mon, 16 Jan 2006 15:55:23 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [patch] networking ipv4: remove total socket usage count from /proc/net/sockstat
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
In-Reply-To: <9a8748490601161235k2defec82sa51a17e4fc14b22f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116200432.GB14060@gospo.rdu.redhat.com>
	 <1137442446.19444.20.camel@mindpipe>
	 <bdfc5d6e0601161225h53554b1ahde794af93af52bdf@mail.gmail.com>
	 <9a8748490601161235k2defec82sa51a17e4fc14b22f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper,

Thanks for the explanation.  Your reasoning makes sense.  I will
consider other ways to solve my current problem and post a patch that
doesn't "break userspace" if necessary.

-andy



On 1/16/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 1/16/06, Andy Gospodarek <andy@greyhouse.net> wrote:
> > What userspace app will break because of this?
> >
> > On 1/16/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Mon, 2006-01-16 at 15:04 -0500, Andy Gospodarek wrote:
> > > > Printing the total number of sockets used in /proc/net/sockstat is out
> > > > of place in a file that is supposed to contain information related to
> > > > ipv4 sockets.  Removed output for total socket usage.
> > > >
> > >
> > > Um, you can't do that, it will break userspace.
> > >
>
> That's not the point. The point is you can't go around changing things
> exported to usersace - that has the potential to break apps.  Even if
> no app is known to the people on this list there may still be apps out
> there depending on it - and we don't break userspace without *very*
> good reasons, and even then it's announced for several months (years
> sometimes) in Documentation/feature-removal.txt and elsewhere.
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
>
