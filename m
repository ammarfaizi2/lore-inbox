Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbUJ0Xcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUJ0Xcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUJ0UvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:51:07 -0400
Received: from smtp08.auna.com ([62.81.186.18]:43923 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S262722AbUJ0UpZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:45:25 -0400
Date: Wed, 27 Oct 2004 20:45:24 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [PATCH] Rename SECTOR_SIZE to BIO_SECTOR_SIZE
To: Matt Mackall <mpm@selenic.com>
Cc: Chris Wedgwood <cw@f00f.org>, Jens Axboe <axboe@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <20041027060828.GA32396@taniwha.stupidest.org>
	<417F4497.3020205@pobox.com> <20041027065524.GA1524@taniwha.stupidest.org>
	<20041027072212.GN15910@suse.de>
	<20041027190523.GA19330@taniwha.stupidest.org>
	<20041027202733.GG28904@waste.org>
In-Reply-To: <20041027202733.GG28904@waste.org> (from mpm@selenic.com on Wed
	Oct 27 22:27:33 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098909924l.12725l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.27, Matt Mackall wrote:
> On Wed, Oct 27, 2004 at 12:05:23PM -0700, Chris Wedgwood wrote:
> > Rename (one of the uses of) SECTOR_SIZE to BIO_SECTOR_SIZE which is
> > more appropriate.
> 
> > Index: cw-current/include/linux/ide.h
> > ===================================================================
> > --- cw-current.orig/include/linux/ide.h	2004-10-27 11:33:06.237319044 -0700
> > +++ cw-current/include/linux/ide.h	2004-10-27 11:35:13.246711414 -0700
> > @@ -202,8 +202,8 @@
> >  #define PARTN_BITS	6	/* number of minor dev bits for partitions */
> >  #define PARTN_MASK	((1<<PARTN_BITS)-1)	/* a useful bit mask */
> >  #define MAX_DRIVES	2	/* per interface; 2 assumed by lots of code */
> > -#define SECTOR_SIZE	512
> > -#define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
> > +#define BIO_SECTOR_SIZE	512
> > +#define SECTOR_WORDS	(BIO_SECTOR_SIZE / 4)	/* number of 32bit words per sector */
> >  #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))
> 
> So shouldn't this be in bio.h now?
> 

And for uniformity, SECTOR_WORDS -> BIO_SECTOR_WORDS ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-jam1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #6


