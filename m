Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137038AbREKCjs>; Thu, 10 May 2001 22:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137039AbREKCji>; Thu, 10 May 2001 22:39:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:28676 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S137038AbREKCjY>; Thu, 10 May 2001 22:39:24 -0400
Date: Thu, 10 May 2001 22:01:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writepage method changes
In-Reply-To: <1537180000.989506272@tiny>
Message-ID: <Pine.LNX.4.21.0105102200110.23350-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 May 2001, Chris Mason wrote:

> 
> 
> On Wednesday, May 09, 2001 10:51:17 PM -0300 Marcelo Tosatti
> <marcelo@conectiva.com.br> wrote:
> 
> > 
> > 
> > On Wed, 9 May 2001, Marcelo Tosatti wrote:
> > 
> >> Locked for the "not wrote out case" (I will fix my patch now, thanks)
> > 
> > I just found out that there are filesystems (eg reiserfs) which write out
> > data even if an error ocurred, which means the unlocking must be done by
> > the filesystems, always. 
> 
> I'm not horribly attached to the way reiserfs is doing it right now.  If
> reiserfs writepage manages to map any blocks, it writes them to disk, even
> if mapping other blocks in the page failed.  These are only data blocks, so
> there are no special consistency rules.  If we need to change this, it is
> not a big deal.

No need for that.

Its saner leaving this control to the filesystems.

