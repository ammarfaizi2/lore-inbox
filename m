Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbTFRQl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTFRQl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:41:29 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:35795 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265270AbTFRQlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:41:18 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Karl Vogel <karl.vogel@seagha.com>, linux-kernel@vger.kernel.org
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like   Windows!
Date: Wed, 18 Jun 2003 18:53:22 +0200
User-Agent: KMail/1.5.1
References: <6DED3619289CD311BCEB00508B8E13360117748D@nt-server2.antwerp.seagha.com>
In-Reply-To: <6DED3619289CD311BCEB00508B8E13360117748D@nt-server2.antwerp.seagha.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306181853.22687.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 18. Juni 2003 11:56 schrieb Karl Vogel:
> > > Swap prefetching? If you have >10% free physical ram and
> >
> > any used swap it
> >
> > > will start swapping pages back into physical ram. Probably
> >
> > not of real
> >
> > > benefit but many people like this idea. I have a soft spot
> >
> > for it and like
> >
> > > using it.
> > > --
> > >
> > > The disadvantage is ofcourse that you will be using up more
> >
> > RAM than is
> >
> > > really necessary.
> >
> > No, free RAM is wasted RAM.
>
> But the point is, it's not really free RAM. It's being used for
> I/O caching. So while swap prefetching might be suited for
> desktop systems, it certainly isn't for servers.

Not entirely. Have a look:

oliver@vermuden:~> free
             total       used       free     shared    buffers     cached
Mem:        514844     501652      13192          0     130124     216476
-/+ buffers/cache:     155052     359792
Swap:      1036152       6120    1030032
oliver@vermuden:~> free
             total       used       free     shared    buffers     cached
Mem:        514844     500500      14344          0     119940     224772
-/+ buffers/cache:     155788     359056
Swap:      1036152       6584    1029568
oliver@vermuden:~>

This is before starting OpenOffice and after quitting it.
As you can see the amount free RAM really goes up. This RAM is wasted.
It will eventually be put to use, but there's nothing wrong with speeding
this up. Reading back swap is almost certainly not the optimum way to
use it, but it's better than nothing at all, provided the RAM is not tied up.
The question is whether it's worth it in terms of IO.

	Regards
		Oliver

