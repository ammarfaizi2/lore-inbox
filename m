Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSFUL45>; Fri, 21 Jun 2002 07:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSFUL44>; Fri, 21 Jun 2002 07:56:56 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:30649 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S316574AbSFUL4z>;
	Fri, 21 Jun 2002 07:56:55 -0400
Date: Fri, 21 Jun 2002 13:56:55 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206211156.NAA13885@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: 2.5.23+ bootflag.c triggers __iounmap: bad address
Cc: ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting 2.5.23/.24, my test boxes generate the following:

(an ASUS P4T-E which has SBF)
__iounmap: bad address d0802100
SBF: Simple Boot Flag extension found and enabled.
__iounmap: bad address d0805040
__iounmap: bad address d0808080
SBF: Setting boot flags 0x1

(an old Intel AL440LX which doesn't have SBF)
__iounmap: bad address c4800009
__iounmap: bad address c4804b8c
__iounmap: bad address c4802009

These warnings/errors are new since 2.5.23, which makes me
suspect something's wrong in the 2.5.23 iounmap changes.

/Mikael
