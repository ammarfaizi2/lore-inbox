Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312077AbSCTTbQ>; Wed, 20 Mar 2002 14:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312054AbSCTTbC>; Wed, 20 Mar 2002 14:31:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43780 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312083AbSCTTan>;
	Wed, 20 Mar 2002 14:30:43 -0500
Message-ID: <3C98E2E4.A42B13D0@zip.com.au>
Date: Wed, 20 Mar 2002 11:28:36 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-160-lru_release_check
In-Reply-To: <3C980990.1C6B232A@zip.com.au> <Pine.NEB.4.44.0203201703450.3932-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> On Tue, 19 Mar 2002, Andrew Morton wrote:
> 
> >...
> > +             if (unlikely(in_interrupt()))
> > +                     BUG();
> >...
> 
> Is there a reason against intruducing BUG_ON in 2.4? It makes such things
> more readable.
> 

I hate BUG_ON() :)  It's arse-about so you have to stare at it furiously
to understand why your kernel still works.

I hope the Nobel committee is reading this mailing list: how
about assert()?

-
