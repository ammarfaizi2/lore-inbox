Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135644AbRAGCsj>; Sat, 6 Jan 2001 21:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135659AbRAGCsU>; Sat, 6 Jan 2001 21:48:20 -0500
Received: from 209.102.21.2 ([209.102.21.2]:21509 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S135644AbRAGCsJ>;
	Sat, 6 Jan 2001 21:48:09 -0500
Message-ID: <3A57A87B.BA60FF9B@goingware.com>
Date: Sat, 06 Jan 2001 23:21:31 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: What test suites can you tell me about?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you tell me about any ready-to-use test suites, for any software package
that should run under Linux, that I can build and run to test the new kernel?

Besides running all these tests myself on my machine, I'm going to document them
in an article at:

http://linuxquality.sunsite.dk/articles/

(there are no articles there yet but I'm composing a couple that will be posted
soon)

For example, if you build Python (http://www.python.org) and say "make check",
it will run a bunch of python programs that test the correctness of the
programming language.

This is of interest in part because lots of the Python tests make system calls,
but also because it tests that the compilers generate correct code under the new
kernel (another test I do is, after I boot off a new kernel, I do "make clean",
build it again and boot off _that_).

"make exec" under the Mesa 3.4 library builds a bunch of graphics demos, a few
of which are kind of whizzy but most of which exercise a few basic functions in
OpenGL.  So one can watch that they don't crash, that the images look correctly
drawn and so on.  This enabled me to realize that DRI wasn't working under 2.4.0
but it was under 2.4.0-prerelease-ac5, which I've detailed in a separate
message.

Another test suite I know about comes with Kaffe (http://www.kaffe.org) and
verifies that Kaffe's implementation of Java is running correctly on your
system.

One I read about somewhere but have no clue where to get it is this memory
stress-testing tool that does lots of DMA and stuff off of the disks.

There must be a lot of these tools available, if only we had them listed all in
one place.

If you maintain such a test tool, it would be helpful if you provided the option
to run the whole suite completely unattended.  Mesa provides a good test for
lots of functions of the kernel, but one problem is that one has to quit the
tests after each one runs, usually by pressing the ESC key.  Unattended testing
also allows one to run lots of tests simultaneously to test a heavily loaded
system. 

In some cases, the tests really do need to have some user input, like navigating
around a 3D world or turning various rendering options on and off, but it's
possible the tests could be extended to allow this input from a script (Python
provides a nice way to bolt a script interpreter to any application).

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
