Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbTBTTEG>; Thu, 20 Feb 2003 14:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTBTTEG>; Thu, 20 Feb 2003 14:04:06 -0500
Received: from crack.them.org ([65.125.64.184]:55782 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S266795AbTBTTEG>;
	Thu, 20 Feb 2003 14:04:06 -0500
Date: Thu, 20 Feb 2003 14:13:58 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Alex Larsson <alexl@redhat.com>, procps-list@redhat.com
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
Message-ID: <20030220191358.GA18459@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Alex Larsson <alexl@redhat.com>, procps-list@redhat.com
References: <Pine.LNX.4.44.0302200902260.2493-100000@home.transmeta.com> <Pine.LNX.4.44.0302200918300.2493-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200918300.2493-100000@home.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 09:20:38AM -0800, Linus Torvalds wrote:
> 
> On Thu, 20 Feb 2003, Linus Torvalds wrote:
> > 
> > It would just be _so_ much nicer if the threads would show up as 
> > subdirectories ie /proc/<tgid>/<tid>/xxx. More scalable, more readable, 
> > and just generally more sane.
> 
> It shouldn't even be all that much harder. You only really need to add the 
> "lookup()" and "readdir()" logic to the pid-fd's, and they both should be 
> fairly straightforward, ie something like the appended should do the 
> lookup() part.
> 
> (UNTESTED! NOT COMPILED! PROBABLY HORRIBLY BUGGY! CAVEAT USER! CONCEPTUAL 
> CODE ONLY! YOU GET THE IDEA! I'M GETTING HOARSE FROM ALL THE SHOUTING!)

It'd be a little (very little) more complex, but can I once again
suggest /proc/<tgid>/threads/<tid> instead of /proc/<tgid>/<tid>/xxx?


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
