Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317984AbSGPVfW>; Tue, 16 Jul 2002 17:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317993AbSGPVfV>; Tue, 16 Jul 2002 17:35:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44551 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317984AbSGPVfU>;
	Tue, 16 Jul 2002 17:35:20 -0400
Message-ID: <3D3491C7.99B35813@zip.com.au>
Date: Tue, 16 Jul 2002 14:36:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Jari Ruusu <jari.ruusu@pp.inet.fi>, Jens Axboe <axboe@suse.de>,
       Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716163636.GW811@suse.de> <Pine.LNX.4.44L.0207161349100.3009-100000@duckman.distro.conectiva> <20020716170921.GX811@suse.de> <3D34773C.F61E7C0F@pp.inet.fi> <20020716211455.GE1096@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Tue, Jul 16, 2002 at 10:42:52PM +0300, Jari Ruusu wrote:
> > The patch below fixes that remap issue, plus uncounted number of other loop
> > issues. For example, device backed loops use pre-allocated pages for zero VM
> > pressure.
> 
> I'd like to understand this (and possibly even use it) as I tend to use
> the loopback block driver often. Any chance you could break this up into
> a blow-by-blow series of bugfixes? As it is here, it's a bit much for me
> to digest as a newbie to bio.
> 
> My needs for explanation are perhaps greater than others on the cc: list,
> so it's really optional, but I'd be much obliged if you could do so.
> 

Seconded, please.  It's obviously an important patch but it's
rather large and opaque.  A description of what it is doing and
in particularly *why* it is doing it would really help.

A nice way of providing such a description is inside

/*
 * these thingies
 */

so the information is not lost.

I particular:

- Does the file_operations-based file-backed IO work with all
  crypto setups?

- What are those preallocated pages doing?  Are they really needed
  with the 2.5 VM?  What problem are they solving?

Thanks.

(BTW: check out the ARRAY_SIZE macro ;))

-
