Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272665AbRIGODa>; Fri, 7 Sep 2001 10:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272666AbRIGODK>; Fri, 7 Sep 2001 10:03:10 -0400
Received: from lxmayr6.informatik.tu-muenchen.de ([131.159.44.50]:2688 "EHLO
	lxmayr6.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S272665AbRIGOC7>; Fri, 7 Sep 2001 10:02:59 -0400
Date: Fri, 7 Sep 2001 16:03:15 +0200
From: Ingo Rohloff <rohloff@in.tum.de>
To: epic@scyld.com, linux-kernel@vger.kernel.org
Subject: epic100.c, gcc-2.95.2 compiler bug!
Message-ID: <20010907160315.D621@lxmayr6.informatik.tu-muenchen.de>
In-Reply-To: <20010903130404.B1064@lxmayr6.informatik.tu-muenchen.de> <20010907160159.C621@lxmayr6.informatik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010907160159.C621@lxmayr6.informatik.tu-muenchen.de>; from rohloff@lxmayr6.informatik.tu-muenchen.de on Fri, Sep 07, 2001 at 04:01:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted an error report about the epic100.c module about one
week before.
The sympotms were lot's of messages of this in /var/log/messages:
"kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004"

After one week of really frustrating debugging and incrementally
morphing the working version of the driver I got into the (for
me) non-working linux-2.4.9 version I finally found out what was
going on: the linux-2.4.9 driver has no bug!

BEWARE: DON'T USE gcc-2.95.2!
I compiled the linux-2.4.9 version with gcc-2.95.2.
And I can _definitely_ confirm that epic100.c triggers a compiler
bug. (I have the erronous assembler code on my harddisk if anyone is
interested.)

Compile the same module with gcc-2.95.3 and the bug is gone
(at least in my case. The assembler code is different and correct.)

conclusion:
Don't use gcc-2.95.2 to compile your kernel!

so long
  Ingo Rohloff

