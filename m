Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSGLVWR>; Fri, 12 Jul 2002 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318015AbSGLVWQ>; Fri, 12 Jul 2002 17:22:16 -0400
Received: from pc132.utati.net ([216.143.22.132]:15237 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S318014AbSGLVWP>; Fri, 12 Jul 2002 17:22:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: No rule to make autoconf.h in 2.4.19-rc1?
Date: Fri, 12 Jul 2002 11:26:44 -0400
X-Mailer: KMail [version 1.3.1]
Cc: marcelo@conectiva.com.br
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020712210434.271CA8B5@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Retry with a hopefully correct address for Marcelo.  (There's only one n in 
conectiva.  Right.)

------------------

I'm trying to put together a linux from scratch system (3.3 with extensive 
tweaks) using a build script that happily built 2.4.18 but is dying at the 
start of make bzImage in 19-rc1, complaining there's no rule to make 
include/linux/autoconf.h (needed by include/config/MARKER).

I've confirmed I got the right patch and that it applied correctly (or at 
least reproducibly without rejects and changed the version numbers in the top 
level makefile)...  I untarred the 2.4.18 tarball into a fresh directory, 
applied the patch, did "make dep" followed by "make clean" (I tried omitting 
make clean and it didn't help) followed by make bzImage, at which point the 
build process went off into the corner to sulk.

Maybe I'm doing something small and simple wrong (although 2.4.18 built), but 
I can't spot it.  I grepped the last couple weeks of my linux-kernel folder 
and the only mention of autoconf.h was in patches, no descriptive text.

I also tried "touch include/linux/autoconf.h", which just makes 
scripts/split-include die in find...

What does the kernel use autoconf for?  (When did this get added?  I wrote a 
kernel output parser and didn't see autoconf, and I'd expect it to run in ake 
dep anyway...)

Er... Help?

Rob
