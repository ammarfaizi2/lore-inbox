Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWHHN5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWHHN5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWHHN5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:57:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9872 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932500AbWHHN5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:57:38 -0400
Date: Tue, 8 Aug 2006 15:57:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Edgar Toernig <froese@gmx.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060808135720.GE4624@elf.ucw.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de> <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com> <20060807224144.3bb64ac4.froese@gmx.de> <1155040157.5729.34.camel@localhost.localdomain> <20060808125747.GB5284@ucw.cz> <1155046496.5729.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155046496.5729.53.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > To use revoke() I must own the file
> > > If I own the file I can make it a symlink to a pty/tty pair
> > > I can revoke a pty/tty pair
> > 
> > How can you symlink opened file?
> 
> I make a symlink before running the app which opens it. Or if the app
> doesn't open it I pass the file handle of a pty/tty pair to it.

Okay, I guess marginal app could do open, then fstat to make sure it
is not pty/tty, then proceed assuming it can't go away. But I see that
chances of _that_ happening are slim.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
