Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131153AbRALOBn>; Fri, 12 Jan 2001 09:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRALOBd>; Fri, 12 Jan 2001 09:01:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131153AbRALOBT>;
	Fri, 12 Jan 2001 09:01:19 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101121134.f0CBYDB04046@flint.arm.linux.org.uk>
Subject: Re: Cannot compile my kernel due to unpredictible situations:
To: cyt@liih.org (Yin Tan Cui)
Date: Fri, 12 Jan 2001 11:34:13 +0000 (GMT)
Cc: gregg_99@mailcity.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101121039590.1542-100000@flash.liih.org> from "Yin Tan Cui" at Jan 12, 2001 10:45:19 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are three golden rules of unpacking a kernel tarball:

1. Make sure that you have sufficient free space on the partition before
   unpacking.

   Reason: the kernel source is not small.  Currently the 2.4.0 kernel is
   around 105MB, but once built it will grow to 125MB or more depending on
   your configuration.

2. Make sure that there isn't a pre-existing file or directory called 'linux'

   Reason: unpacking a new kernel tree over an old kernel tree will give
   unpredicatable results, and may end up with it failing to build, or
   failing to unpack if 'linux' is a file.

3. Never unpack a kernel tar ball in /usr/src

   Reason: some systems still have symlinks from /usr/include/linux into
   /usr/src/linux/include/linux.  The headers in /usr/include/linux are
   supposed to be the ones that your C library was compiled against, not
   the current kernel you are running.

   Suggestion: create a directory called '/usr/src/v2.4.0' and unpack in
   there.  If you need any extra patches, or other utilities (eg, modutils)
   you have a convienient place to keep them for later reference.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
