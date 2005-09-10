Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVIJT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVIJT25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 15:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVIJT25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 15:28:57 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:831 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932175AbVIJT24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 15:28:56 -0400
Date: Sat, 10 Sep 2005 21:30:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/12] kbuild: mips use generic asm-offsets.h support
Message-ID: <20050910193033.GA31516@mars.ravnborg.org>
References: <11263057061465-git-send-email-sam@ravnborg.org> <Pine.LNX.4.61.0509101949240.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509101949240.3743@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman.
 
> >  Kbuild                          |    9 ++++++++-
> 
> What's that file good for?

kbuild looks for the Kbuild file before it looks for Makefile.
In a desire to move some of the functionality away form the top-level
Makefile and in to a kbuild file this is needed.

In this particular case the Kbuild file is located in the top-level
directory because it is used to read a file down in arch/$(ARCH)
and store the result file in include/asm-$(ARCH).
Here it come in handy that kbuild prefer the Kbuild name, since
it would not be good to try to use the top-level Makefile as
a kbuild file. It is full of conditionals and one more
spanning-the-whole-file conditional was too ugly.
It also come in handy that the full kbuild functionality is
available making it possible to do full dependency checking.

The Kbuild file in the top-level directory will take
over more and more functionality from the top-level
Makefile to the extent that I hope to end up with two
readable files.

	Sam
