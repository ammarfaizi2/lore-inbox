Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSEFXsM>; Mon, 6 May 2002 19:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSEFXsL>; Mon, 6 May 2002 19:48:11 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:9988 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S315265AbSEFXsK>; Mon, 6 May 2002 19:48:10 -0400
Date: Mon, 6 May 2002 16:48:00 -0700
From: jw schultz <jw@pegasys.ws>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.13 IDE 53
Message-ID: <20020506164800.A28702@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net> <3CC7E358.8050905@evision-ventures.com> <20020425172508.GK3542@suse.de> <20020425173439.GM3542@suse.de> <aa9qtb$d8a$1@penguin.transmeta.com> <3CD55601.9030604@evision-ventures.com> <20020506105331.A20048@flint.arm.linux.org.uk> <3CD644E5.4070407@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 10:55:01AM +0200, Martin Dalecki wrote:
> Uz.ytkownik Russell King napisa?:
> > 
> > Are you at some point going to add the black/white lists back into
> > icside.c that you removed shortly after you took over the IDE
> > maintainence?  I've been patiently waiting to see what was going to
> > happen to them.
> 
> What about using the generic udma_black_list() and udma_white_list()?
> Just tell so and I could prvide the code for testing.
> 

Just a thought so i'll throw it out there.  I'm just a
spectator so far on this issue as i haven't yet been burned
by it. 

There seem to be several black|white lists floating around.
This would appear to be an ongoing task keeping up with the
new and obscure hardware to cope with capabilities and
compatibilities and often requires kernel or module rebuilds
and means ever-growing lists.

For some time i have been thinking that a common black|white
list API might be worthwhile.  Along with this would be the
ability to examine and modify, or at least add to, the lists
at runtime.  For hot-plug some of the black|white checks
might even be better handled by a daemon that can read an
external file.  That would facilitate testing and allow
people to add support for their hot-plug devices without
reboot.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
