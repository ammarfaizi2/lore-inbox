Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbRFFH5t>; Wed, 6 Jun 2001 03:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbRFFH5i>; Wed, 6 Jun 2001 03:57:38 -0400
Received: from AMontpellier-201-1-3-224.abo.wanadoo.fr ([193.252.1.224]:37624
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S263435AbRFFH52>; Wed, 6 Jun 2001 03:57:28 -0400
Subject: Re: kswapd and MM overload fix
From: Xavier Bestel <xavier.bestel@free.fr>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0106051650340.10118-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0106051650340.10118-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 06 Jun 2001 09:54:04 +0200
Message-Id: <991814046.30689.0.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jun 2001 16:51:13 -0700, Linus Torvalds wrote:
> 
> 
> On Wed, 6 Jun 2001, Andrea Arcangeli wrote:
> >
> > that would fix it too indeed, OTOH I think changing the empty zone
> > handling in the kernel is beyond the scope of the bugfix (grep for
> > zone->size in mm/*.c :). Certainly making empty zones transparent to the
> > vm sounds much cleaner from a mm/*.c point of view but it may be faster
> > to skip the block with a branch instead of always computing it.
> 
> Agreed. I'd like to do both. Having uninitialized random stuff around and
> depending on jumping over code that might access it sounds like really bad
> practice.

Why not explicitely initializing it to weird values, to catch code which
should jump over it (but doesn't) ?

Xav

