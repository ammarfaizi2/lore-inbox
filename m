Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267211AbSLEEc6>; Wed, 4 Dec 2002 23:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbSLEEc6>; Wed, 4 Dec 2002 23:32:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:41451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267211AbSLEEc5>;
	Wed, 4 Dec 2002 23:32:57 -0500
Date: Wed, 4 Dec 2002 22:23:40 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Parallel build broken in latest BK
Message-ID: <Pine.LNX.4.33.0212042215540.924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I typically do 

$ make -j4 MAKE="make -j4" bzImage

to build kernels. However, in the recent bitkeeper tree (as ~7pm CST), it 
fails with:

make -j4 -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
make[1]: warning: -jN forced in submake: disabling jobserver mode.
make[1]: *** read jobs pipe: Is a directory.  Stop.
make[1]: *** Waiting for unfinished jobs....
make: *** [bzImage] Error 2

as the last few lines. However, a single-threaded make completes fine. 

More output is available upon request.

	-pat


