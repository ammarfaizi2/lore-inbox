Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSFJTcH>; Mon, 10 Jun 2002 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315910AbSFJTcG>; Mon, 10 Jun 2002 15:32:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57612 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315893AbSFJTcF>;
	Mon, 10 Jun 2002 15:32:05 -0400
Message-ID: <3D04FE64.B92706E8@zip.com.au>
Date: Mon, 10 Jun 2002 12:30:44 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <5.1.0.14.2.20020610114308.09306358@mail1.qualcomm.com> <Pine.GSO.4.05.10206102055280.17299-100000@mausmaki.cosy.sbg.ac.at> <20020610191959.GJ14252@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> On Mon, Jun 10, 2002 at 08:57:02PM +0200, Thomas 'Dent' Mirlacher wrote:
> > On Mon, 10 Jun 2002, Maksim (Max) Krasnyanskiy wrote:
> >
> > > Hi Martin,
> > >
> > > How about replacing __FUNCTION__ with __func__ ?
> > > GCC 3.x warns that __FUNCTION__ is obsolete and will be removed.
> >
> > is __func__ already supported for gcc 2.96?
> 
> Well it works with 2.95.3, which is the important part...

The 2.5 kernel must be buildable on gcc-2.91.66, aka egcs-1.1.2.

The 2.95.x requirement was reverted because sparc (or sparc64?)
needs egcs-1.1.2.

__func__ does *not* work on egcs-1.1.2 and so cannot be used in Linux.

`struct blah = { .open = driver_open };' *does* work in egcs-1.1.2
and is OK to use.

-
