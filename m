Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264932AbRGWXbF>; Mon, 23 Jul 2001 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264874AbRGWXaz>; Mon, 23 Jul 2001 19:30:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6156 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264877AbRGWXar>; Mon, 23 Jul 2001 19:30:47 -0400
Date: Mon, 23 Jul 2001 20:30:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdev@vger.kernel.org>, <martizab@libertsurf.fr>,
        <rusty@rustcorp.com.au>
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5CADD7.7C7C8337@wanadoo.fr>
Message-ID: <Pine.LNX.4.33L.0107232027120.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Jerome de Vivie wrote:
> Rik van Riel a écrit :

> > Hmmmm, so it's not completely transparent. Good.
>
> You only set a global variable to select on which configuration
> you want to work. You can't do it simplier Rik: everything else
> is transparent: read, write, ... !

*nod*

Sounds like a great idea indeed.

> > Now if you want to make this kernel-accessible, why
> > not make a userland NFS daemon which uses something
> > like bitkeeper or PRCS as its backend ?
> >
> > The system would then look like this:
> >
> >  _____    _______    _____    _____
> > |     |  |       |  |     |  |     |
> > | SCM |--| UNFSD |--| NET |--| NFS |
> > |_____|  |_______|  |_____|  |_____|
>
> Your architecture is too complex for me.

But you only have to implement 10% of it, the rest already
exists.

You already have:
1) Source Control Management system (SCM)
2) Userland NFS daemon (UNFSD)
3) network layer
4) NFS filesystem support (for every OS!)

All you need is a backend for the NFS server daemon to
get its files from a version control system (the SCM)
instead of from disk.

> > And there, you have a transparent SCM filesystem
> > that works over the network ... without ever having
> > to modify the kernel or implement SCM.
>
> I can't do it outside the kernel.

So chose the appropriate "magic directories" for the
NFS daemon ... maybe even "magic mount paths" ?

You're looking at reimplementing the 90% which is
already there (the versioning and the filesystem code)
while leaving the other 10% (the management code) for
a later date ;)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

