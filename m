Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313810AbSDIHhd>; Tue, 9 Apr 2002 03:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313811AbSDIHhc>; Tue, 9 Apr 2002 03:37:32 -0400
Received: from violet.setuza.cz ([194.149.118.97]:7172 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313810AbSDIHhb>;
	Tue, 9 Apr 2002 03:37:31 -0400
Subject: Re: [2.5 patch] hdreg.h must include types.h
From: Frank Schaefer <frank.schafer@setuza.cz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.44.0204041640550.7845-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Apr 2002 09:37:32 +0200
Message-Id: <1018337852.620.6.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 16:50, Adrian Bunk wrote:
> On Thu, 4 Apr 2002, Martin Dalecki wrote:
> 
> > The proper fix is to add linux/types.h in ide-pnp.c in front
> > of linux/hdreg.h inclusion. Nested includes are *nasty*.
> 
> Why are they nasty? My impression is that they give you a cleaner API in
> the sense that you know that when you need something from e.g.
> linux/hdreg.h you can simply include this file without bothering which
> other header files are needed by this file. The only problem I'm currently
> seeing is that circular dependencies between header files might be a
> problem but it shouldn't be too hard to check that there are no circular
> dependencies. Are there any other problems I don't see?
> 

Agree,

and assuming that every header begins with sonething like
#ifndef HEADER_INCLUDED
we save a lot of typing and error prone-ness.

Frank

