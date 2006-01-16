Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWAPUfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWAPUfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWAPUfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:35:32 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:47808 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbWAPUfb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:35:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hBVMFjArE9HZnoS5OZ+axCziwUfXknepo3BonQSkBLmuP1seoBfvdA5Ul58rifNOW9J1vA2Cm1w9d7SHpMtddcLpbL+RoKi5xSJ1KAA/EtctXlzBQtYLCjfwmpJ9BJIwphvGInc6slyG0mHZ8DUy+RaZWrcSdA7gftYQeDtL/TY=
Message-ID: <9a8748490601161235k2defec82sa51a17e4fc14b22f@mail.gmail.com>
Date: Mon, 16 Jan 2006 21:35:28 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andy Gospodarek <andy@greyhouse.net>
Subject: Re: [patch] networking ipv4: remove total socket usage count from /proc/net/sockstat
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
In-Reply-To: <bdfc5d6e0601161225h53554b1ahde794af93af52bdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116200432.GB14060@gospo.rdu.redhat.com>
	 <1137442446.19444.20.camel@mindpipe>
	 <bdfc5d6e0601161225h53554b1ahde794af93af52bdf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Andy Gospodarek <andy@greyhouse.net> wrote:
> What userspace app will break because of this?
>
> On 1/16/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Mon, 2006-01-16 at 15:04 -0500, Andy Gospodarek wrote:
> > > Printing the total number of sockets used in /proc/net/sockstat is out
> > > of place in a file that is supposed to contain information related to
> > > ipv4 sockets.  Removed output for total socket usage.
> > >
> >
> > Um, you can't do that, it will break userspace.
> >

That's not the point. The point is you can't go around changing things
exported to usersace - that has the potential to break apps.  Even if
no app is known to the people on this list there may still be apps out
there depending on it - and we don't break userspace without *very*
good reasons, and even then it's announced for several months (years
sometimes) in Documentation/feature-removal.txt and elsewhere.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
