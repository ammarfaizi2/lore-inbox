Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSIEOQj>; Thu, 5 Sep 2002 10:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSIEOQj>; Thu, 5 Sep 2002 10:16:39 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:49929 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317571AbSIEOQi>;
	Thu, 5 Sep 2002 10:16:38 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: davidm@hpl.hp.com
Date: Thu, 5 Sep 2002 16:20:17 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: BK Changeset 1.615 - Makefile fix breaks i386...
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <EE17182D9A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,
  after your $ARCH => $(ARCH) fix in main Makefile make system
on my machine now believes that arch/i386/vmlinux.lds should
be built through vmlinux.lds.S => (rule in Makefile) vmlinux.lds.s => 
(default as,ld) => vmlinux.lds, although neither of vmlinux.lds.S nor 
vmlinux.lds.s does exist :-( So build fails.

  I was not able to fix problem other way than moving
arch/$(ARCH)/vmlinux.lds.s rule down to arch's Makefiles, but I believe
that there must be some better way to do that...
                                  Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
