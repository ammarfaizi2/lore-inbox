Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTBTQpk>; Thu, 20 Feb 2003 11:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTBTQpk>; Thu, 20 Feb 2003 11:45:40 -0500
Received: from crack.them.org ([65.125.64.184]:2788 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S265947AbTBTQpj>;
	Thu, 20 Feb 2003 11:45:39 -0500
Date: Thu, 20 Feb 2003 11:55:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
Message-ID: <20030220165540.GA17006@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain> <b330qj$sri$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b330qj$sri$1@news.cistron.nl>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 04:47:15PM +0000, Miquel van Smoorenburg wrote:
> In article <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>,
> Ingo Molnar  <mingo@elte.hu> wrote:
> >the fix for this is two-fold. First, it must be possible for procps to
> >separate 'threads' from 'processes' without having to go into 16 thousand
> >directories. I solved this by prefixing 'threads' (ie. non-group-leader
> >threads) with a dot ('.') character in the /proc listing:
> 
> Why not put threads belonging to a thread group into /proc/17072/threads ?

I'm also inclined to think this is a good idea.  We could even choose
to use /proc/17072/lwp, to match Solaris, but it's probably not worth
it since the semantics are different.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
