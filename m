Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136282AbRDVUBr>; Sun, 22 Apr 2001 16:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136283AbRDVUBi>; Sun, 22 Apr 2001 16:01:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56849 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S136282AbRDVUBX>;
	Sun, 22 Apr 2001 16:01:23 -0400
Date: Sun, 22 Apr 2001 21:01:18 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Subject: Architecture-specific include files
Message-ID: <20010422210118.Z18464@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Something which came up in one of the hallway discussions at the
kernelsummit was that a lot of the architecture maintainers would find
it more convenient if the arch-specific header files were moved from
include/asm-$ARCH to arch/$ARCH/include.  Since we use a symlink _anyway_,
no global changes to include statements are necessary, we'd merely need
to change Makefile from

symlinks:
        rm -f include/asm
        ( cd include ; ln -sf asm-$(ARCH) asm)

to

symlinks:
        rm -f include/asm
        ( cd include ; ln -sf ../arch/$(ARCH)/include asm)

Would anyone have a problem with this change?  It'll make for a hell
of a big patch from Linus, but it really will simplify the lives of the
architecture maintainers.

-- 
Revolutions do not require corporate support.
