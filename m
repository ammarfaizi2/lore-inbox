Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRGWWaA>; Mon, 23 Jul 2001 18:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbRGWW3u>; Mon, 23 Jul 2001 18:29:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45829 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262436AbRGWW3g>; Mon, 23 Jul 2001 18:29:36 -0400
Date: Mon, 23 Jul 2001 19:29:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Cc: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdev@vger.kernel.org>, <martizab@libertsurf.fr>,
        <rusty@rustcorp.com.au>
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5CA2EC.2498775@wanadoo.fr>
Message-ID: <Pine.LNX.4.33L.0107231925040.20326-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 24 Jul 2001, Jerome de Vivie wrote:
> Rik van Riel a écrit :
> > On Mon, 23 Jul 2001, Larry McVoy wrote:
> >
> > > b) Filesystem support for SCM is really a flawed approach.
> >
> > Agreed.  I mean, how can you cleanly group changesets and
> > versions with a filesystem level "transparent" SCM ?
>
> With label !
>
> In my initial post, i have explain that labels are used to
> identify individual files AND are also uses to select for
> each files of a set, one version (= select a configuration).
> It works !

Hmmmm, so it's not completely transparent. Good.

Now if you want to make this kernel-accessible, why
not make a userland NFS daemon which uses something
like bitkeeper or PRCS as its backend ?

The system would then look like this:

 _____    _______    _____    _____
|     |  |       |  |     |  |     |
| SCM |--| UNFSD |--| NET |--| NFS |
|_____|  |_______|  |_____|  |_____|


And there, you have a transparent SCM filesystem
that works over the network ... without ever having
to modify the kernel or implement SCM.


> versioning is yet a first step.

And I'm not convinced it is even needed. All you
really need is the glue layer between the SCM
system and the kernel. A user level NFS server
will do this just fine.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

