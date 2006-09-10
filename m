Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWIJHwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWIJHwv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 03:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWIJHwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 03:52:51 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:31530 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750749AbWIJHwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 03:52:51 -0400
Date: Sun, 10 Sep 2006 09:51:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 1/2] own header file for struct page.
Message-ID: <20060910075154.GA8354@osiris.ibm.com>
References: <20060908111716.GA6913@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0609092248400.6762@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609092248400.6762@scrub.home>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In order to get of all these problems caused by macros it seems to
> > be a good idea to get rid of them and convert them to static inline
> > functions. Because of header file include order it's necessary to have a
> > seperate header file for the struct page definition.
> > 
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > ---
> > 
> > Patches are against git tree as of today. Better ideas welcome of course.
> > 
> >  include/linux/mm.h   |   64 --------------------------------------------
> >  include/linux/page.h |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+), 63 deletions(-)
> 
> To avoid the explosion in number of small header files each containing a 
> single definition, it would be better to generally split between the 
> definitions and implementations, so IMO mm_types.h with all the structures 
> and defines from mm.h would be better.

That could be done, but I wouldn't know where to start and where to end.
Moving simply all definitions to mm_types.h doesn't seem to be a good
solution. E.g. having something like "struct shrinker" in mm_types.h
seems to be rather pointless IMHO.
Maybe we can simply leave it by just taking the struct page definition
out for now?
