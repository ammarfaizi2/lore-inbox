Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289929AbSAWRna>; Wed, 23 Jan 2002 12:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289930AbSAWRnU>; Wed, 23 Jan 2002 12:43:20 -0500
Received: from dpt-info.u-strasbg.fr ([130.79.44.193]:37132 "EHLO
	dpt-info.u-strasbg.fr") by vger.kernel.org with ESMTP
	id <S289929AbSAWRnF>; Wed, 23 Jan 2002 12:43:05 -0500
Date: Wed, 23 Jan 2002 18:42:40 +0100
From: Sven <luther@dpt-info.u-strasbg.fr>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
Message-ID: <20020123184240.A3926@dpt-info.u-strasbg.fr>
In-Reply-To: <20020123184002.A3858@dpt-info.u-strasbg.fr> <Pine.GSO.4.21.0201231841010.26747-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0201231841010.26747-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Wed, Jan 23, 2002 at 06:41:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 06:41:38PM +0100, Geert Uytterhoeven wrote:
> On Wed, 23 Jan 2002, Sven wrote:
> > On Wed, Jan 23, 2002 at 06:34:03PM +0100, Geert Uytterhoeven wrote:
> > > On Wed, 23 Jan 2002, Sven wrote:
> > > > Also, since when does the B_FREE or NODEV exists ? I did put the changes into
> > > > a #ifdef kernel 2.5, and kept the -1 for kernels 2.4, but i guess i could
> > > > remove this check altogether if the NODEV was present from the begining. And
> > > 
> > > IIRC, Marcelo added NODEV to 2.4.x in one of his latest releases, just to solve
> > > this problem.
> > > 
> > > > what about 2.2 kernels ?
> > > 
> > > No idea. Ask Alan :-)
> > 
> > Ok, so the best thing would be to keep the #ifdef then.
> > 
> > or maybe i could try an :
> > 
> > #ifdef NODEV
> > 	..node = NODEV
> > #else
> > 	..node = -1
> > #endif
> > 
> > ?
> 
> Or even shorter (and cleaner, IMHO):
> 
> #ifndef NODEV
> #define NODEV	-1
> #endif

yes, ...

Friendly,

Sven Luther
