Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTDQEtK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 00:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTDQEtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 00:49:10 -0400
Received: from dnvrdslgw14poolC198.dnvr.uswest.net ([63.228.86.198]:33117 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id S262953AbTDQEtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 00:49:09 -0400
Date: Wed, 16 Apr 2003 23:01:06 -0600 (MDT)
From: Benson Chow <blc@q.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ac97, alc101+kt8235 sound
In-Reply-To: <1050424108.27745.77.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304162257080.6238-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right, it's not necessary.

It just reports as 'Unknown' but works same as with the patch.

After some more testing, it plays fine, mixer works mostly, minus the
issue with recording.  Attempting to record seems to inject 60 cycle hum
into the system and recorded output either bombs out or is just the hum -
no line-in signal is recorded.  Looks like the realtek alc101 has some
quirks...

-bc

On 15 Apr 2003, Alan Cox wrote:

> Date: 15 Apr 2003 17:28:29 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Benson Chow <blc@q.dyndns.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: ac97, alc101+kt8235 sound
>
> On Maw, 2003-04-15 at 18:09, Benson Chow wrote:
> > What's the normal flow to get this added into ac97_codecs.c?
> >
> > +        {0x414C4730, "ALC101",             &null_ops},
> >
> > Adding this line into the table in ac97_codecs.c (with a few missing
> > #defines fixed... then I noticed they're already in -ac1 :) in
> > 2.4.21-pre7 made sound work fine.
>
> This really shouldnt make any difference. Does it work without that
> patch as well ?
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

WARNING: All HTML emails get deleted.  DO NOT SEND HTML MAIL.

