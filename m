Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282082AbRLCIvd>; Mon, 3 Dec 2001 03:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284493AbRLCIur>; Mon, 3 Dec 2001 03:50:47 -0500
Received: from rj.SGI.COM ([204.94.215.100]:61408 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S284558AbRLCBGW>;
	Sun, 2 Dec 2001 20:06:22 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Converting the 2.5 kernel to kbuild 2.5
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Dec 2001 12:06:12 +1100
Message-ID: <1861.1007341572@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, the time has come to convert the 2.5 kernel to kbuild 2.5.  I
want to do this in separate steps to make it easier for architectures
that have not been converted yet.

2.5.1           Semi-stable kernel, after bio is working.

2.5.2-pre1      Add the kbuild 2.5 code, still using Makefile-2.5.
                i386, sparc, sparc64 can use either kbuild 2.4 or 2.5,
                2.5 is recommended.
                ia64 can only use kbuild 2.5.
                Other architectures continue to use kbuild 2.4.
                Wait 24 hours for any major problems then -

2.5.2-pre2      Remove kbuild 2.4 code, rename Makefile-2.5 to Makefile.
                i386, ia64, sparc, sparc64 can compile using kbuild 2.5.
                Other architectures cannot compile until they convert
                to kbuild 2.5.  The kbuild group can help with the
                conversion but without access to a machine we cannot
                test other architectures.  Until the other archs have
                been converted, they can stay on 2.5.2-pre1.

Doing the change in two steps provides a platform where both kbuild 2.4
and 2.5 work.  This allows other architectures to parallel test the old
and new kbuild during their conversion, I found that ability was very
useful during conversion.

The CML1 to CML2 conversion comes later, either in 2.5.3 or 2.5.4.

Linus, is this acceptable?

