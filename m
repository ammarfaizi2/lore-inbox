Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268214AbRGXQlB>; Tue, 24 Jul 2001 12:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268219AbRGXQkv>; Tue, 24 Jul 2001 12:40:51 -0400
Received: from smtp-rt-5.wanadoo.fr ([193.252.19.159]:39163 "EHLO
	bassia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S268214AbRGXQkm>; Tue, 24 Jul 2001 12:40:42 -0400
Message-ID: <3B5DA57F.5779D623@wanadoo.fr>
Date: Tue, 24 Jul 2001 18:42:39 +0200
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
In-Reply-To: <Pine.LNX.4.33L.0107232027120.20326-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi Rik,

Rik van Riel a écrit :
> 
> On Tue, 24 Jul 2001, Jerome de Vivie wrote:
> > You only set a global variable to select on which configuration
> > you want to work. You can't do it simplier Rik: everything else
> > is transparent: read, write, ... !
> 
> *nod*
> 
> Sounds like a great idea indeed.

thx ;-)

> 
> > > Now if you want to make this kernel-accessible, why
> > > not make a userland NFS daemon which uses something
> > > like bitkeeper or PRCS as its backend ?
> > >
> > > The system would then look like this:
> > >
> > >  _____    _______    _____    _____
> > > |     |  |       |  |     |  |     |
> > > | SCM |--| UNFSD |--| NET |--| NFS |
> > > |_____|  |_______|  |_____|  |_____|
> >
> > Your architecture is too complex for me.

I've re-thought my draft and... your architecture is 
not so complex ! 

Here's pros for userland SCM:
-easier to write
-easier to maintain (and no synchronization with kernel dvlp)
-work under every type of FS
-portable
-force me not to touch FS and properly write interface between
the SCM extension and the FS.


And cons:
-Multiple entry point to access data ( => risk of inconsistancy)
-Perhaps, a filesystem is the best place to put file (...even 
for multiple-version files)

As it was mention by A. Viro, do it in the kernel may lead
to "devfs like" problems (...even after big simplifictions
like "one node for all version of a file").

I've change a bit my opinion: i'm not sure that userland
is the best place (...because there are cons pending) but,
i'm now nearest the userland solution of "hacking a nfsd".

j.

-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
