Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317858AbSHHRod>; Thu, 8 Aug 2002 13:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSHHRoc>; Thu, 8 Aug 2002 13:44:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:54545 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317858AbSHHRoa>; Thu, 8 Aug 2002 13:44:30 -0400
Date: Thu, 8 Aug 2002 14:47:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Joshua MacDonald <jmacd@namesys.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>, <phillips@arcor.de>, <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020808174317.GG8804@reload.namesys.com>
Message-ID: <Pine.LNX.4.44L.0208081446340.2589-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Joshua MacDonald wrote:
> On Thu, Aug 08, 2002 at 02:31:40PM -0300, Rik van Riel wrote:
> > On Thu, 8 Aug 2002, Jesse Barnes wrote:

> > > Agreed.  I'll post another patch that doesn't mess with the scsi
> > > stuff.  Maybe later I can put together a useful
> > > 'lock-not-held-on-this-cpu' macro.
> >
> > You don't need to put this in a macro.  This test is valid
> > for ALL spinlocks in the kernel and can be done from inside
> > the spin_lock() macro itself, when spinlock debugging is on.
>
> This is just not true.  When you make this assertion, it doesn't mean
> you intend to take the lock.  It could have to do with lock ordering, or
> it could be testing that some lock is properly released.

Hmm, I guess you might be right.  This could indeed be useful
for indirectly called functions like ->open() functions in
drivers, etc...

kind regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

