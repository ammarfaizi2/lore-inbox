Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280471AbRJaUIk>; Wed, 31 Oct 2001 15:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280470AbRJaUIb>; Wed, 31 Oct 2001 15:08:31 -0500
Received: from mail.myrio.com ([63.109.146.2]:12026 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S280469AbRJaUIK>;
	Wed, 31 Oct 2001 15:08:10 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAA7@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Roy Sigurd Karlsbakk'" <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: RE: EM8400/8401 support?
Date: Wed, 31 Oct 2001 12:08:30 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:

> strange...
> I found a package called NetStream2000-0.2.047.1.tar.gz with 
> these drivers
> with source on Sigma's site. 

That GPL'ed source code (from the "kernelmode" directory of the tarball)
contains only the source for the interface between the driver and the
kernel.  Compiling that gives you a small module, but AFIK, there is no way
(well, no documentation) to use that module to actually do anything useful
or interesting.  

To actually do anything (like decode MPEG-2 video) with the hardware, you
use the large (400K) closed-source libEM8400.so library.  That library talks
to the hardware using the module.  I suppose you could try to
reverse-engineer that by observing all the communication between the lib and
the driver, but that's probably not allowed.

So, in short: The only documentation is on how to use libEM8400, and that's
closed source.  But hey, it works, so things could be worse.  

(I suppose one could have an discussion on the legality of this GPL'ed
kernel module / closed driver, but I'm sure most readers of the list are
sick and tired of amateur legal discussion, I guess Sigma's lawyers decided
it was legal, and they know better than me.)

Torrey
