Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSFFCrE>; Wed, 5 Jun 2002 22:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFFCrD>; Wed, 5 Jun 2002 22:47:03 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:55987 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316682AbSFFCrD>; Wed, 5 Jun 2002 22:47:03 -0400
Date: Wed, 5 Jun 2002 23:18:50 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Guest section DW <dwguest@win.tue.nl>
Cc: rbt@mtlb.co.uk, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] Trivial, IDE geometry fix / defconfig changes
Message-Id: <20020605231850.68f44678.rusty@rustcorp.com.au>
In-Reply-To: <20020604234146.GA7255@win.tue.nl>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 01:41:46 +0200
Guest section DW <dwguest@win.tue.nl> wrote:

> On Tue, Jun 04, 2002 at 09:56:17PM +0100, Robert Cardell wrote:
> 
> > --- ide-disk.c.old	Tue Jun  4 21:09:10 2002
> > +++ ide-disk.c	Tue Jun  4 21:09:44 2002
> > @@ -929,9 +929,9 @@
> >  
> >  	if (id->cfs_enable_2 & 0x0400) {
> >  		capacity_2 = id->lba_capacity_2;
> > -		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
> >  		drive->head		= drive->bios_head = 255;
> >  		drive->sect		= drive->bios_sect = 63;
> > +		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
> >  		drive->select.b.lba	= 1;
> >  		set_max_ext = idedisk_read_native_max_address_ext(drive);
> >  		if (set_max_ext > capacity_2) {
> > 
> 
> Yes, let me confirm: this patch is required.
> I sent it to the list on 10 Feb 2002 ("[PATCH] tiny IDE fixes"); apparently
> nobody picked it up, or at least it didnt reach 2.4.19-pre9 yet.
> That patch also removed some dead code.

If you'd sent it to the trivial patch maintainer... <plug plug>

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
