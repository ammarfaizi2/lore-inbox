Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262010AbSJIRuN>; Wed, 9 Oct 2002 13:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSJIRuN>; Wed, 9 Oct 2002 13:50:13 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:20746 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262010AbSJIRtw>;
	Wed, 9 Oct 2002 13:49:52 -0400
Date: Wed, 9 Oct 2002 19:55:31 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
Message-ID: <20021009195531.B1708@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>
References: <20021009191600.A1708@mars.ravnborg.org> <Pine.LNX.4.44.0210091033200.7355-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210091033200.7355-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Oct 09, 2002 at 10:37:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 10:37:47AM -0700, Linus Torvalds wrote:
> However, I disagree with the naming - I'd rather have one common name for
> the "main" directory entry than have magic rules like "basename of the
> directory capitalized". I don't want to have to search for it.

OK, see your point here.

> I also think I'd perfer to have them all start with the same thing, so 
> that (again) it's clear when a directory has multiple configuration files. 
> 
> So instead: how about just "Config" for the main per-directory
> configuration file, with sub-config's being "Config.3c5xx" and
> "Config.rrunner".
I look at it the other way around. I want to make it clear that there
exist a separate Config file for a given subset of files. The normal
approach is to group files based on their filenames.
Therefore I prefer a fixed suffix, as opposed to a fixed prefix.

ls rrunner*
should show me not only the implementation [.c + .h] but also
the configuration.

The only reason I stick with the .conf prefix for the main per-directory
configuration file is to have a common suffix on all config files.

So I would suggest:

Config.conf		<= Main entry in any directory
sensible-name.conf	<= Any group of related files

ls *.conf 	list all configuration files.
ls rrunner*	list all files spcific for rrunner

It's so easy to have opinions about naming ;-)

	Sam
