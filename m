Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271633AbRH0A1h>; Sun, 26 Aug 2001 20:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271634AbRH0A11>; Sun, 26 Aug 2001 20:27:27 -0400
Received: from zok.SGI.COM ([204.94.215.101]:54224 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S271633AbRH0A1W>;
	Sun, 26 Aug 2001 20:27:22 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: 2.4.9-ac12 ppc ftr_fixup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Aug 2001 10:27:22 +1000
Message-ID: <19943.998872042@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.9-ac12 has new ppc code for CPU feature fixups.  The ftr_fixup code
only handles entries that are built into the kernel.  timex.h defines
get_cycles() using ftr_fixup and get_cycles() is used all over the
place, including in modules.  AFAICT we need to add modutils support
for ftr_fixup.

Don't write any code yet, Maciej W. Rozycki has some patches for a
similar problem in mips and his fix is nicely extensible.  I just need
confirmation that ftr_fixup needs modutils support.

