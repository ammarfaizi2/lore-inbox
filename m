Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270633AbTGNNrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270623AbTGNNpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:45:18 -0400
Received: from angband.namesys.com ([212.16.7.85]:32640 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S270434AbTGNNoh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:44:37 -0400
Date: Mon, 14 Jul 2003 17:59:24 +0400
From: Oleg Drokin <green@namesys.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Chris Mason <mason@suse.com>
Subject: Re: PATCH: use the right function in reiserfs (resend #3)
Message-ID: <20030714135924.GA1120@namesys.com>
References: <200307141230.h6ECUvx9030962@hraefn.swansea.linux.org.uk> <Pine.LNX.4.55L.0307141042320.18257@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307141042320.18257@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jul 14, 2003 at 10:44:13AM -0300, Marcelo Tosatti wrote:

> Do you reiserfs people have anything pending (so you could merge Alan
> patch) or can I apply ?

You can apply this one.
We (namesys) do not have anything pending for 2.4.22

> On Mon, 14 Jul 2003, Alan Cox wrote:
> > #ra1
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.22-pre5/fs/reiserfs/prints.c linux.22-pre5-ac1/fs/reiserfs/prints.c
> > --- linux.22-pre5/fs/reiserfs/prints.c	2003-07-14 12:27:42.000000000 +0100
> > +++ linux.22-pre5-ac1/fs/reiserfs/prints.c	2003-07-06 14:06:59.000000000 +0100
> > @@ -159,7 +159,7 @@
> >
> >    *skip = 0;
> >
> > -  while ((k = strstr (k, "%")) != NULL)
> > +  while ((k = strchr (k, '%')) != NULL)
> >    {
> >      if (k[1] == 'k' || k[1] == 'K' || k[1] == 'h' || k[1] == 't' ||
> >  	      k[1] == 'z' || k[1] == 'b' || k[1] == 'y' || k[1] == 'a' ) {
> >

Bye,
    Oleg
