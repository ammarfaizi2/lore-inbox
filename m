Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278664AbRJSVeB>; Fri, 19 Oct 2001 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278665AbRJSVdv>; Fri, 19 Oct 2001 17:33:51 -0400
Received: from mout0.freenet.de ([194.97.50.131]:13986 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S278664AbRJSVdf>;
	Fri, 19 Oct 2001 17:33:35 -0400
Date: Fri, 19 Oct 2001 23:35:35 +0200 (CEST)
From: Richard Guenther <richard@tat.physik.uni-tuebingen.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <Pine.GSO.4.21.0110191422570.24783-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1011019233051.456A-100000@mickey.hamnixda.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001, Alexander Viro wrote:

> On Fri, 19 Oct 2001, Richard Guenther wrote:
> 
> > Hi Linus,
> > 
> > As Al pissed me off again with complaining about binfmt_misc, please
> > apply the attached patch which corrects the 'not C code' line and
> > fixes the problem Albert noticed. This doesnt fix various assumptions
> > about the /proc code that were either valid at the time of writing
> > binfmt_misc or badly/not documented.

As binfmt_misc write access is root only, I didnt care to check
too much as root can shoot himself anyway. Some places could use
more checking, some even less.

> Or, say it, one about meaning of
>         if ((count == 1) && !(buffer[0] & ~('0' | '1'))) {
> not being the same as
>         if (count == 1 && (buffer[0] == '0' || buffer[0] == '1')) {

Err, who said that it is the same?? Its sufficient, if you trust
root to just pass '0' or '1'. Ok, its probably too clever for the
average C programmer, but it seems I didnt care.

> Please, learn C.  Then learn some basic stuff about kernel programming.
> Then feel free to start mouthing off.

Well, try to get some basic communication style and you'll even
get a long with guys like me.

> As for the version in -ac and maintaining it - sure I will.

Just get Linus to take the -ac version then. I'm sick to read
your comments about binfmt_misc over and over again. You've
made your point(s) - more than one time. Thats enough. Welcome
to my killfile now.

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
PGP: 2E829319 - 2F 83 FC 93 E9 E4 19 E2 93 7A 32 42 45 37 23 57
WWW: http://www.anatom.uni-tuebingen.de/~richi/

