Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285401AbRLGESW>; Thu, 6 Dec 2001 23:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285402AbRLGESM>; Thu, 6 Dec 2001 23:18:12 -0500
Received: from zok.sgi.com ([204.94.215.101]:22432 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S285401AbRLGESF>;
	Thu, 6 Dec 2001 23:18:05 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Dec 2001 15:17:53 +1100
Message-ID: <24493.1007698673@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, the time has come to convert the 2.5 kernel to kbuild 2.5.  I
want to do this in separate steps to make it easier for architectures
that have not been converted yet.

2.5.1           Semi-stable kernel, after bio is working.

2.5.2-pre1      Add the kbuild 2.5 and CML2 code, still using
                Makefile-2.5, supporting both CML1 and CML2.
                i386, sparc, sparc64 can use either kbuild 2.4 or 2.5,
                2.5 is recommended.
                ia64 can only use kbuild 2.5.
                Other architectures continue to use kbuild 2.4.
                Wait 24 hours for any major problems then -

2.5.2-pre2      Remove kbuild 2.4 code, rename Makefile-2.5 to Makefile.
		Still supporting both CML1 and CML2.
                i386, ia64, sparc, sparc64 can compile using kbuild 2.5.
                Other architectures cannot compile until they convert
                to kbuild 2.5.  The kbuild group can help with the
                conversion but without access to a machine we cannot
                test other architectures.  Until the other archs have
                been converted, they can stay on 2.5.2-pre1.
                Wait 24 hours for any major problems then -

2.5.2-pre3      Remove CML1 support.

Doing the change in steps provides a platform where both kbuild 2.4 and
2.5 work and both CML1 and CML2 are available.  This allows other
architectures to parallel test the old and new kbuild and CML during
their conversion, I found that ability was very useful during
conversion.

Linus, is this acceptable?  When do you want the kbuild 2.5 and CML2
patches?

