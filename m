Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290586AbSARSd1>; Fri, 18 Jan 2002 13:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290588AbSARSdI>; Fri, 18 Jan 2002 13:33:08 -0500
Received: from willow.seitz.com ([207.106.55.140]:47115 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S290586AbSARSc5>;
	Fri, 18 Jan 2002 13:32:57 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Fri, 18 Jan 2002 13:32:53 -0500
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
Message-ID: <20020118133253.A14488@willow.seitz.com>
In-Reply-To: <20020115145324.A5772@thyrsus.com> <20020115152643.A6846@willow.seitz.com> <20020115230211.A5177@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020115230211.A5177@thyrsus.com>; from esr@thyrsus.com on Tue, Jan 15, 2002 at 11:02:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

Finally got around to trying 2.1.6 - everything works great, and I'm really
impressed!  Looks like killer stuff.  Two things:

1) I noticed you've been pining the lists for EISA information.  I don't know a
whole lot about EISA systems or anything, but I do have a 486 EISA board and
an EISA network card I'd be willing to send you if you wanted a system to play
around with.  I don't use it anymore and it's just gathering dust in my
basement.

2) It seems that searching is broken.  I didn't see anything in TODO and
couldn't find any bug reports on linux-kernel or kbuild-devel.  Pressing '/' to
search on any screen, for any text results in the following crash:

Traceback (most recent call last):
  File "cml2/cmlconfigure.py", line 3312, in ?
    main(options, arguments)
  File "cml2/cmlconfigure.py", line 3218, in main
    curses.wrapper(curses_style_menu, config, banner)
  File "/usr/lib/python2.0/curses/wrapper.py", line 44, in wrapper
    res = apply(func, (stdscr,) + rest)
  File "cml2/cmlconfigure.py", line 1154, in __init__
    self.interact(config)
  File "cml2/cmlconfigure.py", line 1782, in interact
    recompute = self.symbol_menu_command(cmd, sel_symbol)
  File "cml2/cmlconfigure.py", line 1535, in symbol_menu_command
    configuration.debug_emit(1, "hits: " + str(hits))
  File "cml2/cmlsystem.py", line 134, in _newstr
    if symbol.frozen():
  File "cml2/cmlsystem.py", line 154, in _frozen
    if symbol.iced:
AttributeError: 'ConfigSymbol' instance has no attribute 'iced'
make: *** [menuconfig] Error 1

Other than that, this look really awesome!


Thanks,
	Ross Vandegrift
	ross@willow.seitz.com
