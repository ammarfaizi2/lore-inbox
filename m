Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSFCTjk>; Mon, 3 Jun 2002 15:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSFCTjj>; Mon, 3 Jun 2002 15:39:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37297 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314491AbSFCTjj>;
	Mon, 3 Jun 2002 15:39:39 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 3 Jun 2002 21:39:28 +0200 (MEST)
Message-Id: <UTC200206031939.g53JdSJ17872.aeb@smtp.cwi.nl>
To: kernel@bonin.ca, linux-kernel@vger.kernel.org
Subject: Re: Support for keyboards with special scancodes
Cc: bonin@bonin.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I have an Logitech Internet Navigator keyboard that has nice little 
    'play', 'pause', 'e-mail' buttons of all kinds (As many of us do, i 
    believe).  I couldn't find any specialised keyboard drivers in the 
    kernel.  Only different locales.

    I'me wondering if it was possible to write a driver that would overlay 
    the existing keyboard driver and pitch non-standardized scancodes codes 
    in a /dev file (in a standard format).  One could then create a daemon 
    that would poll this file for changes to this file and perform the 
    resulting action.

    Does something like this already exist?

Yes, several people made such things.
To quote one example:

=====
The FunKey kernel patch that adds a `keycode interpretation type' that says
`send a code out over /dev/funkey'. The `funky' daemon reads this character
device and starts plain Un*x commands in response. The code is independent
of the kbd_mode, so it works under textual mode as well as under XFree86.

The patch applies to Linux 2.2.14 and comes with a simple example daemon.
You can pick both up at

    http://home.zonnet.nl/vanrein/linux/funkey
=====

(I have not checked whether the URL still works -
this post is two years old.)

Andries
