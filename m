Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313906AbSDZL5A>; Fri, 26 Apr 2002 07:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313907AbSDZL47>; Fri, 26 Apr 2002 07:56:59 -0400
Received: from [195.223.140.120] ([195.223.140.120]:35104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313906AbSDZL46>; Fri, 26 Apr 2002 07:56:58 -0400
Date: Fri, 26 Apr 2002 13:57:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Ihno Krumreich <ihno@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: get_pid fixes against 2.4.19pre7
Message-ID: <20020426135718.E19278@dualathlon.random>
In-Reply-To: <20020426134409.C19278@dualathlon.random> <20020426125347.A18131@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 12:53:47PM +0100, Russell King wrote:
> On Fri, Apr 26, 2002 at 01:44:09PM +0200, Andrea Arcangeli wrote:
> > +			set_bit(p->pid, pid_bitmap);
> > +			set_bit(p->pgrp, pid_bitmap);
> > +			set_bit(p->tgid, pid_bitmap);
> > +			set_bit(p->session, pid_bitmap);
> 
> Since we're running under a lock, do we really need the guaranteed
> atomic (and therefore expensive) set_bit(), or would __set_bit()
> suffice?

__set_bit definitely suffices, thanks.

Andrea
