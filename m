Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSHHHf0>; Thu, 8 Aug 2002 03:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSHHHf0>; Thu, 8 Aug 2002 03:35:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30901 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316535AbSHHHfZ>;
	Thu, 8 Aug 2002 03:35:25 -0400
Date: Thu, 8 Aug 2002 09:37:56 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: martin@dalecki.de
Cc: Andries.Brouwer@cwi.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [bug, 2.5.29, (not IDE)] partition table (not) corruption?
In-Reply-To: <3D521E07.8070908@evision.ag>
Message-ID: <Pine.LNX.4.44.0208080935170.31228-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Aug 2002, Marcin Dalecki wrote:

> >>LILO without "linear" or "lba32" is inherently broken: it will talk CHS
> >>at boot time to the BIOS and hence needs a geometry and install time,
> >>and nobody knows the geometry required. So, if LILO doesnt break, this
> >>is pure coincidence.
> > 
> > 
> > well, lilo without linear worked for like years on this box ...
> 
> You have to take in to account that by creating a new kernel image
> you are storing it sometimes after a long long time at perhaps maybe
> another block group far away.  This is becouse ext2 suddenly may feel
> like doing so...And surprisingly you have to teach lilo about the new
> far away sectors becouse basic C/H/S addressing can't reach them
> anylonger. Been there seen that frequently enough.

this particular testbox has seen *thousands* of development kernels of all
sizes, and i often have filled up the complete /boot partition. It is very
unlikely that this harmless (and not too big) 2.5.29 kernel would have
been the first one to trigger a 'wrong' CHS combination. Especially since
2.4 kernels with exactly the *same* bzImage (and same lilo) work just
fine.

	Ingo

