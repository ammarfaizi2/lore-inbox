Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276914AbRKAAnO>; Wed, 31 Oct 2001 19:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276982AbRKAAnG>; Wed, 31 Oct 2001 19:43:06 -0500
Received: from rj.SGI.COM ([204.94.215.100]:31957 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S276973AbRKAAm4>;
	Wed, 31 Oct 2001 19:42:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: kbuild 2.5 preventing mixture of compilers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Nov 2001 11:43:22 +1100
Message-ID: <26322.1004575402@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, kbuild 2.5 will check that all the kernel and modules were
compiled with the same version of gcc, in particular they must all have
the same value of

  $(CC) -v 2>&1 | sed -ne '1s:.*/\([^/]*/[^/]*\)/[^/]\+$:\1:p'

e.g. i386-redhat-linux/2.96

Minor version data such as build date is assumed to be irrelevant.
Anybody who makes significant changes to compiler output without
changing the version number gets what they deserve.

Modules built with a different compiler from the kernel will not load
unless they are forced with insmod -f.

Is this going to cause problems for anybody?  I see no justification
for mixing kernel objects built by different compilers and I know of
problems that have been caused by doing so.

