Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135941AbRDTO6g>; Fri, 20 Apr 2001 10:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135943AbRDTO61>; Fri, 20 Apr 2001 10:58:27 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:25057 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S135940AbRDTO6N>; Fri, 20 Apr 2001 10:58:13 -0400
Message-Id: <200104201456.f3KEuor01481@debye.wins.uva.nl>
Date: Fri, 20 Apr 2001 16:56:50 +0200 (MET DST)
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
From: Mark Kettenis <kettenis@science.uva.nl>
To: linux-kernel@vger.kernel.org
CC: wichert@cistron.nl, ebrunet@quatramaran.ens.fr, torvalds@transmeta.com
Subject: Re: Children first in fork
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The behaviour of CLONE_PTRACE in Linux 2.4.x is different from the
behaviour in 2.2.x.  Linus is describing the 2.4.x. behaviour, where
the program that's doing the tracing will get the events instead of
the "real" parent.  I believe the 2.2.x behaviour was pretty much
useless, and IIRC that was the reason that Linus accepted a patch for
the new behaviour.  I've tested CLONE_PTRACE in the sense that the
development version of GDB contains some code that allows debugging of
any clone() based thread stuff if the threads implementationion
specifies CLONE_PTRACE in its clone() calls.  That way GDB notices new
threads automagically.  It only works on Linux 2.4.x of course, and I
still have to hack something up to make this functionality in GDB
available to the user.

Mark
