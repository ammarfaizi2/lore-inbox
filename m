Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264244AbRGWXDn>; Mon, 23 Jul 2001 19:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRGWXDe>; Mon, 23 Jul 2001 19:03:34 -0400
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:39625 "EHLO
	bassia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264244AbRGWXDT>; Mon, 23 Jul 2001 19:03:19 -0400
Message-ID: <3B5CADD7.7C7C8337@wanadoo.fr>
Date: Tue, 24 Jul 2001 01:05:59 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
        linux-fsdev@vger.kernel.org, martizab@libertsurf.fr,
        rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <Pine.LNX.4.33L.0107231925040.20326-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel a écrit :
> 
> On Tue, 24 Jul 2001, Jerome de Vivie wrote:
> > Rik van Riel a écrit :
> > > On Mon, 23 Jul 2001, Larry McVoy wrote:
> > >
> > > > b) Filesystem support for SCM is really a flawed approach.
> > >
> > > Agreed.  I mean, how can you cleanly group changesets and
> > > versions with a filesystem level "transparent" SCM ?
> >
> > With label !
> >
> > In my initial post, i have explain that labels are used to
> > identify individual files AND are also uses to select for
> > each files of a set, one version (= select a configuration).
> > It works !
> 
> Hmmmm, so it's not completely transparent. Good.

You only set a global variable to select on which configuration
you want to work. You can't do it simplier Rik: everything else 
is transparent: read, write, ... !

> 
> Now if you want to make this kernel-accessible, why
> not make a userland NFS daemon which uses something
> like bitkeeper or PRCS as its backend ?
> 
> The system would then look like this:
> 
>  _____    _______    _____    _____
> |     |  |       |  |     |  |     |
> | SCM |--| UNFSD |--| NET |--| NFS |
> |_____|  |_______|  |_____|  |_____|

Your architecture is too complex for me.

> 
> And there, you have a transparent SCM filesystem
> that works over the network ... without ever having
> to modify the kernel or implement SCM.
> 


I can't do it outside the kernel. There is one important 
feature i have mention: I would like to mix file from the 
"base" filesystem and files which are managed under 
configuration. Why is this feature really important ? 
Because in the product, there are two kind of files:
-source (leaf on the dependency tree)
-and generated files.
As you know in SCM, generated files are not identify by version 
number, but by a configuration (a set with one version for each 
dependencies). So, there is no need to manage all objects of a 
partition under version control.


j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
