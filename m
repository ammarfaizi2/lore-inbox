Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274720AbRJJEs1>; Wed, 10 Oct 2001 00:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274746AbRJJEsI>; Wed, 10 Oct 2001 00:48:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25380 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274720AbRJJEsB>; Wed, 10 Oct 2001 00:48:01 -0400
Date: Wed, 10 Oct 2001 06:48:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Robert Love <rml@tech9.net>, Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Message-ID: <20011010064833.M726@athlon.random>
In-Reply-To: <20011010035818.A556B1E760@Cantor.suse.de> <20011010062300.H726@athlon.random> <20011010044242.82D131E768@Cantor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011010044242.82D131E768@Cantor.suse.de>; from Dieter.Nuetzel@hamburg.de on Wed, Oct 10, 2001 at 06:42:37AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 06:42:37AM +0200, Dieter Nützel wrote:
> Am Mittwoch, 10. Oktober 2001 06:23 schrieb Andrea Arcangeli:
> > On Wed, Oct 10, 2001 at 05:57:46AM +0200, Dieter Nützel wrote:
> 
> [...]
> > > I get the dropouts (2~3 sec) after dbench 32 is running for 9~10 seconds.
> 
> It is mostly only _ONE_ dropout like above.

One isn't really too bad actually, if there's an huge I/O going on at
least.

> The above plus nice -20 mpg123 *.mp3
> I've forgotten to clearify this, sorry.
> 
> Should I try 2.4.11 + 00_vm-1 or 2.4.11aa1, again?

2.4.11aa1 with also read/write reschedule points would be more
interesting I think.

> > You're probably more interested in the possible heuristic that I've in
> > mind to avoid xmms to wait I/O completion for the work submitted by
> > dbench. Of course assuming the vm write throttling was a relevant cause
> > of the dropouts, and that the dropouts weren't just due an I/O
> > congestion (too low disk bendwith).
> 
> > BTW, to find out if the reason of the dropouts where the vm write
> > throttling or the too low disk bandwith you can run ps l <pid_of_xmms>,
> 
> What do you mean here? I can't find a meaningfully ps option.

I meant the output of `ps l` (WCHAN column xmms row).

Andrea
