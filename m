Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262879AbREVW6L>; Tue, 22 May 2001 18:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262880AbREVW6C>; Tue, 22 May 2001 18:58:02 -0400
Received: from pC19F5836.dip.t-dialin.net ([193.159.88.54]:20485 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S262879AbREVW5x> convert rfc822-to-8bit;
	Tue, 22 May 2001 18:57:53 -0400
Message-ID: <3B0AEEEA.225A0940@baldauf.org>
Date: Wed, 23 May 2001 00:57:47 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org, "James H. Puttick" <james.puttick@kvs.com>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <Pine.LNX.4.30.0105230009160.23340-100000@cola.teststation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Urban Widmark wrote:

> On Mon, 21 May 2001, Xuan Baldauf wrote:
>
> > That is annoying, because it heavily slows down bulk transfers of small
> > writes, like automatically unzipping a new mozilla build from the linux box to
> > the windows box. Every write of say 100 bytes is implemented as
> >
> > send write req
> > recv write ack
> > send flush req
> > sync to disk (on the windows machine)
> > recv flush ack
>
> The only other way I have found so far to get it to return the right file
> size is to do a "seek-to-end". That still means an extra SMB but it avoids
> the very painful "sync to disk".
>
> Fortunately the seek is only necessary when refreshing inode info, on a
> "win95" server, on a file that is open and that we have written to.

Maybe it is also a workaround for the problem where changes on the windows side are not reflected?

>
>
> This should be significantly better, but still works with my testcases.
> patch vs 2.4.5-pre4, please test.
>
> /Urban
>

[...patch...]

Is it possible to resend the patch in mime format or publish it somewhere accessible by an URL? Netscape Messenger
creates spaces everywhere where tabs should be :-(

Xuân.


