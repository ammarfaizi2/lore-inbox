Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSLTUYb>; Fri, 20 Dec 2002 15:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSLTUYb>; Fri, 20 Dec 2002 15:24:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:29861 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261686AbSLTUYb>;
	Fri, 20 Dec 2002 15:24:31 -0500
Message-ID: <3E037E38.42B8E01F@digeo.com>
Date: Fri, 20 Dec 2002 12:31:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH]Timer list init is done AFTER use
References: <3E02D81F.13A5A59D@mvista.com> <3E02F073.BF57207C@digeo.com> <3E0350CA.6B99F722@mvista.com> <3E0370C1.21909EF5@digeo.com> <3E03772A.D5D85171@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2002 20:31:52.0345 (UTC) FILETIME=[D4671090:01C2A866]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> ...
> > The logical thing is to implement arch_consoles_callable().  Does
> > this look workable?
> 
> I am not sure.  The first question is when does the online
> bit get set for cpu 0.

Too late, probably.  We might need an escape clause for the boot
CPU there.

>  The next is that it does inhibit a
> rather large block of printks.  Is this ok?

They get buffered, so the info will come out eventually.  But we do want
it to come out in a timely manner.
 
> Mind you, I have not tried it yet...

I think it's the right approach.  I can take poke at it if you like.
