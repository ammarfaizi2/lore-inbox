Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSAQBf4>; Wed, 16 Jan 2002 20:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288057AbSAQBfq>; Wed, 16 Jan 2002 20:35:46 -0500
Received: from mercury.mv.net ([199.125.85.40]:45817 "EHLO mercury.mv.net")
	by vger.kernel.org with ESMTP id <S288051AbSAQBfd>;
	Wed, 16 Jan 2002 20:35:33 -0500
Message-Id: <200201170135.UAA02298@mercury.mv.net>
Content-Type: text/plain; charset=US-ASCII
From: jeff millar <jeff@wa1hco.mv.com>
Organization: me? organized?
To: esr@thyrsus.com
Subject: Fwd: cml2-2.1.4 lockup confirmation
Date: Wed, 16 Jan 2002 20:35:40 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get similar hangs.  Here's from make menuconfig, down to
"Architecture-independent feature selections" and try to turn modules to N.

As soon as I hit N...it hang for 60 sec and then bombs with...

Traceback (most recent call last):
  File "cml2/cmlconfigure.py", line 3283, in ?
    main(options, arguments)
  File "cml2/cmlconfigure.Architecture-independent feature selectionspy",
line 3193, in main
    curses.wrapper(curses_style_menu, config, banner)
  File "/tmp/32444-i386/install/usr/lib/python2.1/curses/wrapper.py", line
44, in wrapper
  File "cml2/cmlconfigure.py", line 1133, in __init__
    self.interact(config)
  File "cml2/cmlconfigure.py", line 1757, in interact
    recompute = self.symbol_menu_command(cmd, sel_symbol)
  File "cml2/cmlconfigure.py", line 1464, in symbol_menu_command
    self.set_symbol(operand, cml.n)
  File "cml2/cmlconfigure.py", line 1255, in set_symbol
    effects + [lang["BADREQUIRE"]] + map(lambda x: x.message, violations),
beep=1)
  File "cml2/cmlconfigure.py", line 1255, in <lambda>
    effects + [lang["BADREQUIRE"]] + map(lambda x: x.message, violations),
beep=1)
AttributeError: message
make: *** [menuconfig] Error 1

When I tried it from make oldconfig.  It didn't hang it just took a long time
to configure hundreds of modules to Y...just what I didn't want, but we've
talked about that.

-------------------------------------------------------
