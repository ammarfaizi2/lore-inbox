Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUBZP1P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbUBZP1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:27:14 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:16393 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S261993AbUBZP1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:27:01 -0500
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040225031553.GC17390@guug.org>
References: <20040224214106.GA17390@guug.org>
	 <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
	 <20040225031553.GC17390@guug.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077809216.2681.107.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 16:26:57 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 04:15, Otto Solares wrote: 
> 
> 4. Memory mappings.
> 	We can currently map the vmem and io regions in userspace.  It
> 	current exists problems with highmem but in short it simply works
> 	for dumb chips or programable chips so specialized libs (like
> 	mesa-solo) can do a decent job.

I hope Mesa-solo doesn't bang the chip directly, does it? That would
mean root only.

And while we're brainstorming... :)

I'm not sure being able to map the whole video RAM is a good idea in the
long run either; at some point we probably need a centralized memory
manager, and I think ideally it should map the allocated regions
separately (which could allow for moving them between video RAM, GART
and system RAM transparently, e.g.) and only allow to use them for
acceleration by opaque handles (via the DRM or whatever). This would be
quite a lot of stuff in the kernel, but I'm not sure it can be done
safely in user space...


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

